
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this.  -->

# DCTreePops

<!-- badges: start -->

<!-- badges: end -->

The goal of DCTreePops is to seamlessly combine spatial data on the
trees and people of Washington D.C. to explore the relationships between
population and tree density.

## Installation

The development version of DCTreePops is available from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Reed-Math241/pkgGrpt")
```

## About the Data

The data were collected and made freely available by the [U.S. Census
Bureau](https://opendata.dc.gov/datasets/acs-2018-population-variables-tract)
and [DC
GIS](https://opendata.dc.gov/datasets/f6c3c04113944f23a7993f2e603abaf2_23).
Further, the data are comprised of observations from each of Washington
DC’s 179 subdivisions and 13 variables divided into three broad
categories: physical geographic data, population data, and tree data.
For geographic data we have the GEO ID, Census Tract name, geometric
shape (including length and area), and respective land and water area.
Then, for both population and trees, we have raw estimates and density
values. Please note, too, that all of our units are in metric.

``` r
library(DCTreePops)
data(package = 'DCTreePops')
```

``` r
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
#> ✓ tibble  3.1.0     ✓ dplyr   1.0.4
#> ✓ tidyr   1.1.2     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.0
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
glimpse(DCTreePops)
#> Rows: 179
#> Columns: 13
#> $ object_id       <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,…
#> $ geo_id          <chr> "11001000100", "11001000201", "11001000202", "11001000…
#> $ name            <chr> "Census Tract 1", "Census Tract 2.01", "Census Tract 2…
#> $ land_area       <int> 1907610, 503312, 776437, 1010802, 1542759, 940586, 581…
#> $ water_area      <int> 512798, 0, 428754, 2334, 69, 30822, 0, 71, 0, 0, 16821…
#> $ shape_length    <dbl> 16275.593, 4265.956, 13196.755, 5244.314, 7468.468, 87…
#> $ shape_area      <dbl> 3157969.9, 832414.2, 1284189.1, 1675991.3, 2552695.0, …
#> $ total_pop       <int> 5160, 3817, 4541, 6334, 1428, 3545, 3371, 4969, 5873, …
#> $ total_pop_moe   <int> 480, 700, 688, 530, 133, 295, 263, 338, 433, 380, 511,…
#> $ pop_density     <dbl> 2704.9554, 7583.7651, 5848.5106, 6266.3113, 925.6144, …
#> $ trees_per_tract <int> 2083, 84, 1514, 1766, 1954, 375, 1130, 2247, 817, 419,…
#> $ tree_density    <dbl> 1091.9423, 166.8945, 1949.9328, 1747.1275, 1266.5620, …
#> $ geometry        <list> [<-77.06470, -77.06469, -77.06470, -77.06471, -77.064…
```

## Example

The most unique aspect of our package is the accessible and easy to use
spatial data. We recommend using geom\_sf() within ggplot2 to display
the spacial data in this set. The graphic below depicts one such usage
of spacial data, and shows the ratio of trees to people in each Census
tract. Please note that the National Mall was intentionally omitted from
this particular graph because it dramatically skewed the scaling.

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

The core question this data package gets at is: what is the relationship
between the density of people and trees in Washington DC? The following
graph is one such investigation of that question.

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

## License

Data are available by CC-0 license –so have at it.
