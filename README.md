[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R-CMD-check-bioc](https://github.com/sneumann/xcms/workflows/R-CMD-check-bioc/badge.svg)](https://github.com/sneumann/xcms/actions?query=workflow%3AR-CMD-check-bioc)
[![codecov.io](https://codecov.io/github/sneumann/xcms/coverage.svg?branch=master)](https://codecov.io/github/sneumann/xcms?branch=master)
[![Years in Bioconductor](http://www.bioconductor.org/shields/years-in-bioc/xcms.svg)](http://www.bioconductor.org/packages/release/bioc/html/xcms.html)
[![Ranking by downloads](http://bioconductor.org/shields/downloads/release/xcms.svg)](https://bioconductor.org/packages/stats/bioc/xcms/)
[![Bioconductor release build status](http://www.bioconductor.org/shields/build/release/bioc/xcms.svg)](http://www.bioconductor.org/packages/release/bioc/html/xcms.html)
[![Bioconductor devel build status](http://www.bioconductor.org/shields/build/devel/bioc/xcms.svg)](http://www.bioconductor.org/checkResults/devel/bioc-LATEST/xcms.html)


# The `xcms` package: pre-processing GC/LC-MS/MS data

Please see the [package documentation](https://sneumann.github.io/xcms/) for
more information and examples.


## Version 4

Version 4 adds native support for the
[Spectra](https://github.com/RforMassSpectrometry/Spectra) package to `xcms` and
allows to perform the pre-processing on `MsExperiment` objects (from the
[MsExperiment](https://github.com/RforMassSpectrometry/MsExperiment). The new
supported data containers (`Spectra`, `MsExperiment` and `XcmsExperiment`) allow
more flexible analyses and seamless future extensions to additional types of
data (such as ion mobility data). Ultimately, these changes will also allow
easier integration of `xcms` with other R packages such as
[MsFeatures](https://github.com/RforMassSpectrometry/MsFeatures) or
[MetaboAnnotation](https://github.com/RforMassSpectrometry/MetaboAnnotation).

While it is suggested that users switch to the newer data and result objects,
all functionality from version 3 and before remain fully supported.


## Version 3

Version >= 3 of the `xcms` package are updated and partially re-written versions
of the original `xcms` package. The version number *3* was selected to avoid
confusions with the `xcms2` (http://pubs.acs.org/doi/abs/10.1021/ac800795f)
software. While providing all of the original software's functionality, `xcms`
version >= 3 aims at:

1) Better integration into the Bioconductor framework:
  - Make use and extend classes defined in the `MSnbase` package.
  - Implement class versioning (Biobase's `Versioned` class).
  - Use `BiocParallel` for parallel processing.
2) Implementation of validation methods for all classes to ensure data
   integrity.
3) Easier and faster access to raw spectra data.
4) Cleanup of the source code:
  - Remove obsolete and redundant functionality (`getEIC`, `rawEIC` etc).
  - Unify interfaces, i.e. implement a layer of base functions accessing all
    analysis methods (which are implemented in C, C++ or R).
5) Using a more consistent naming scheme of methods that follows established
   naming conventions (e.g. `correspondence` instead of `grouping`).
6) Update, improve and extend the documentation.
7) Establishing a layer of base R-functions that interface all analysis
   methods. These should take M/Z, retention time (or scan index) and intensity
   values as input along with optional arguments for the downstream functions
   (implemented in C, C++ or R). The input arguments should be basic R objects
   (numeric vectors) thus enabling easy integration of analysis methods in other
   R packages.
8) The user interface's analysis methods should take the (raw) data object and a
   parameter class, that is used for dispatching to the corresponding analysis
   algorithm.

Discussions and suggestions are welcome:
https://github.com/sneumann/xcms/issues
