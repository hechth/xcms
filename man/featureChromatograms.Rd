% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/XcmsExperiment.R,
%   R/methods-XCMSnExp.R
\name{featureChromatograms}
\alias{featureChromatograms}
\alias{featureChromatograms,XcmsExperiment-method}
\alias{featureChromatograms,XCMSnExp-method}
\title{Extract ion chromatograms for each feature}
\usage{
featureChromatograms(object, ...)

\S4method{featureChromatograms}{XcmsExperiment}(
  object,
  expandRt = 0,
  expandMz = 0,
  aggregationFun = "max",
  features = character(),
  return.type = "XChromatograms",
  chunkSize = 2L,
  ...,
  progressbar = TRUE,
  BPPARAM = bpparam()
)

\S4method{featureChromatograms}{XCMSnExp}(
  object,
  expandRt = 0,
  aggregationFun = "max",
  features,
  include = c("feature_only", "apex_within", "any", "all"),
  filled = FALSE,
  n = length(fileNames(object)),
  value = c("maxo", "into"),
  expandMz = 0,
  ...
)
}
\arguments{
\item{object}{\code{XcmsExperiment} or \code{XCMSnExp} object with grouped
chromatographic peaks.}

\item{...}{optional arguments to be passed along to the \code{\link[=chromatogram]{chromatogram()}}
function.}

\item{expandRt}{\code{numeric(1)} to expand the retention time range for each
chromatographic peak by a constant value on each side.}

\item{expandMz}{\code{numeric(1)} to expand the m/z range for each chromatographic
peak by a constant value on each side. Be aware that by extending the
m/z range the extracted EIC might \strong{no longer} represent the actual
identified chromatographic peak because intensities of potential
additional mass peaks within each spectra would be aggregated into the
final reported intensity value per spectrum (retention time).}

\item{aggregationFun}{\code{character(1)} specifying the name that should be
used to aggregate intensity values across the m/z value range for
the same retention time. The default \code{"max"} returns a base peak
chromatogram.}

\item{features}{\code{integer}, \code{character} or \code{logical} defining a subset of
features for which chromatograms should be returned. Can be the index
of the features in \code{featureDefinitions}, feature IDs (row names of
\code{featureDefinitions}) or a logical vector.}

\item{return.type}{\code{character(1)} defining how the result should be
returned. At present only \code{return.type = "XChromatograms"} is
supported and the results are thus returned as an \code{\link[=XChromatograms]{XChromatograms()}}
object.}

\item{chunkSize}{For \code{object} being an \code{XcmsExperiment}: \code{integer(1)}
defining the number of files from which the data should be loaded at
a time into memory. Defaults to \code{chunkSize = 2L}.}

\item{progressbar}{\code{logical(1)} defining whether a progress bar is shown.}

\item{BPPARAM}{For \code{object} being an \code{XcmsExperiment}: parallel processing
setup. Defaults to \code{BPPARAM = bpparam()}. See \code{\link[=bpparam]{bpparam()}} for more
information.}

\item{include}{Only for \code{object} being an \code{XCMSnExp}: \code{character(1)}
defining which chromatographic peaks (and related feature definitions)
should be included in the returned \code{\link[=XChromatograms]{XChromatograms()}}.
Defaults to \code{"feature_only"}; See description above for options and
details.}

\item{filled}{Only for \code{object} being an \code{XCMSnExp}: \code{logical(1)} whether
filled-in peaks should be included in the result object. The default
is \code{filled = FALSE}, i.e. only detected peaks are reported.}

\item{n}{Only for \code{object} being an \code{XCMSnExp}: \code{integer(1)} to optionally
specify the number of \emph{top n} samples from which the EIC should be
extracted.}

\item{value}{Only for \code{object} being an \code{XCMSnExp}: \code{character(1)}
specifying the column to be used to sort the samples. Can be either
\code{"maxo"} (the default) or \code{"into"} to use the maximal peak intensity
or the integrated peak area, respectively.}
}
\value{
\code{\link[=XChromatograms]{XChromatograms()}} object. In future, depending on parameter
\code{return.type}, the data might be returned as a different object.
}
\description{
Extract ion chromatograms for features in an \link{XcmsExperiment} or
\linkS4class{XCMSnExp} object. The function returns for each feature the
extracted ion chromatograms (along with all associated chromatographic
peaks) in each sample. The chromatogram is extracted from the m/z - rt
region including all chromatographic peaks of that features (i.e. based on
the ranges of \code{"mzmin"}, \code{"mzmax"}, \code{"rtmin"}, \code{"rtmax"} of all
chromatographic peaks of the feature).

By default only chromatographic peaks associated with a feature are
included. For \code{object} being a \code{XCMSnExp} object parameter \code{include}
allows also to return all chromatographic peaks with their apex
position within the selected region (\code{include = "apex_within"}) or any
chromatographic peak overlapping the m/z and retention time range
(\code{include = "any"}).
}
\note{
Parameters \code{include}, \code{filled}, \code{n} and \code{value} are only supported
for \code{object} being an \code{XCMSnExp}.

When extracting EICs from only the top \code{n} samples it can happen that one
or more of the features specified with \code{features} are dropped because they
have no detected peak in the \emph{top n} samples. The chance for this to happen
is smaller if \code{x} contains also filled-in peaks (with \code{fillChromPeaks}).
}
\examples{

## Load a test data set with detected peaks
faahko_sub <- loadXcmsData("faahko_sub2")

## Disable parallel processing for this example
register(SerialParam())

## Subset the object to a smaller retention time range
xdata <- filterRt(faahko_sub, c(2500, 3500))

xdata <- groupChromPeaks(xdata,
    param = PeakDensityParam(minFraction = 0.8, sampleGroups = rep(1, 3)))

## Get the feature definitions
featureDefinitions(xdata)

## Extract ion chromatograms for the first 3 features. Parameter
## `features` can be either the feature IDs or feature indices.
chrs <- featureChromatograms(xdata,
    features = rownames(featureDefinitions)[1:3])

## Plot the XIC for the first feature using different colors for each file
plot(chrs[1, ], col = c("red", "green", "blue"))
}
\seealso{
\code{\link[=filterColumnsKeepTop]{filterColumnsKeepTop()}} to filter the extracted EICs keeping only
the \emph{top n} columns (samples) with the highest intensity.
}
\author{
Johannes Rainer
}
