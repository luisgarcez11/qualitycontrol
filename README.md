
# qualitycontrol

The goal of qualitycontrol is to set a data quality control framework

## Installation

You can install the qualitycontrol from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("luisgarcez11/qualitycontrol")
```

### Data

The `als_data` dataset will be used to guide you through the package
functionality. This data is not real, but based on data retrieved from
Amyotrophic Lateral Sclerosis patients.

``` r
library(qualitycontrol)
als_data
```

    ##    subjid p1 p2 p3 p4 p5 p6 p7 p8 p9 x1r x2r x3r age_at_baseline age_at_onset
    ## 1       1  4  1  1  3  4  3  4  3  4   2   2   1              51           46
    ## 2       2  4  4  4  1  1  3  3  1  4   1   2   4              82           77
    ## 3       3  2  3  1  4  3  1  3  1  1   4   3   1              85           80
    ## 4       4  3  2  1  1  4  1  3  2  4   4   3   3              77           72
    ## 5       5  3  2  1  3  3  4  4  3  4   1   4   2              85           80
    ## 6       6  2  2  1  4  1  4  4  3  1   3   5   2              73           68
    ## 7       7  1  4  2  4  3  3  2  3  4   1   2   2              65           60
    ## 8       8  2  2  4  4  3  2  1  2  3   3   1   1              50           62
    ## 9       9  3  1  1  4  4  2  4  1  1   2   2   4              65           46
    ## 10     10  3  4  1  4  3  2  3  2  1   4   3   1              81           76
    ## 11     11  1  3  1  3  3  4  1 NA  3   3   2   4              51           46
    ## 12     12  1  4  3  2  3  2  2 NA  1   3   2   3              50           45
    ## 13     13  1  1  4  1  1  3  4 NA  2   2   3   1              82           77
    ## 14     14  3  2  2  4  3  3  3  3  2   3   4   1              76           71
    ## 15     15  3  4  2  2  2  3  1  3  4   4   1   4              87          376
    ## 16     16  3  3  2  4  3  3  1  1  2   2   4   1              50           45
    ## 17     17  3  2  3  1  4  1  3  2  1   4   4   2              85           80
    ## 18     18  4  1  3  1  3  1  3  2  2   4   3   4              57           52
    ## 19     19  1  3  3  2  2  2  3  2  3   2   3   2              74           69
    ## 20     20  2  2  4  2  3  4  2  4  1   4   1   3              59           54
    ## 21     21  2  3  3  2  3  2  4  4  1   1   3   3              79           74
    ## 22     22  4  3  1  1  3  4  2  1  4   1   2   3              53           48
    ## 23     23  3  3  4  3  4  1  3  4  3   2   2   2              45           40
    ## 24     24  4  1  1  2  4  2  4  4  4   4   2   1              72           67
    ## 25     25  4  3  1  3  3  4  3  2  3   3   4   2              77           72
    ## 26     26  2  1  1  2  4  2  4  1  2   3   2   4              65           60
    ## 27     27  1  1  1  1  1  1  3  3  2   2   1   1              54           49
    ## 28     28  3  1  1  3  1  4  1  2  2   2   3   4              50          -23
    ## 29     29  2  3  1  3  1  4  4  1  3   2   4   1              85           80
    ## 30     30  3  1  2  1  3  1  2  4  1   1   2   4              85           80
    ## 31     30  3  3  1  4  2  2  1  4  3   3   1   3              53           48
    ##          onset baseline_date death_date
    ## 1       bulbar    2003-03-26 2010-10-18
    ## 2        bulba    2003-07-03 2019-06-24
    ## 3       spinal    2007-01-27 9999-12-30
    ## 4       bulbar    2010-11-27 2018-01-04
    ## 5       bulbar    2006-10-25 2017-10-13
    ## 6       spinal    2007-04-30 2010-05-08
    ## 7       spinal    2002-11-15 2019-04-06
    ## 8       spinal    2002-12-13 2018-05-04
    ## 9       spinal    2005-06-02 2013-08-11
    ## 10      bulbar    2004-06-02 2016-05-20
    ## 11      bulbar    2007-03-09 2016-09-26
    ## 12      bulbar    2005-01-11 2010-06-20
    ## 13      bulbar    2010-12-22 2019-07-05
    ## 14      bulbar    2008-10-14 2013-08-14
    ## 15      spinal    2005-09-15 2010-07-20
    ## 16      spinal    2007-07-05 2010-08-28
    ## 17 respiratory    2002-08-19 2011-10-17
    ## 18      spinal    2002-06-30 2020-12-17
    ## 19 respiratory    2010-07-18 2016-05-15
    ## 20      spinal    2004-08-15 2015-03-15
    ## 21      bulbar    2006-04-07 2013-03-16
    ## 22      bulbar    2002-06-01 2016-06-21
    ## 23      bulbar    2007-08-12 2017-04-01
    ## 24      bulbar    2006-08-12 2002-12-02
    ## 25 respiratory    2006-08-11 2016-03-03
    ## 26      spinal    2005-01-04 2011-10-05
    ## 27 respiratory    2009-08-25 2015-03-11
    ## 28      bulbar    2002-05-11 2017-11-09
    ## 29      bulbar    2004-07-27 2014-03-27
    ## 30      bulbar    2005-11-11 2015-05-30
    ## 31      bulbar    2008-02-27 2014-07-05

### QC mapping

The `als_data_qc_mapping` is an `R list` which contains 3 tables
specifying all the tests used for quality control. You can specify your
own tests, by creating an excel file and then read it using the function
`read_qc_mapping`.

#### Missing

``` r
als_data_qc_mapping$missing
```

    ## # A tibble: 13 × 3
    ##    qc_type    variable type   
    ##    <chr>      <chr>    <chr>  
    ##  1 duplicated subjid   text   
    ##  2 missing    p1       numeric
    ##  3 missing    p2       numeric
    ##  4 missing    p3       numeric
    ##  5 missing    p4       numeric
    ##  6 missing    p5       numeric
    ##  7 missing    p6       numeric
    ##  8 missing    p7       numeric
    ##  9 missing    p8       numeric
    ## 10 missing    p9       numeric
    ## 11 missing    x1r      numeric
    ## 12 missing    x2r      numeric
    ## 13 missing    x3r      numeric

#### Inconsistencies

``` r
als_data_qc_mapping$inconsistencies
```

    ## # A tibble: 2 × 6
    ##   qc_type             variable1       type1   relation     variable2    type2  
    ##   <chr>               <chr>           <chr>   <chr>        <chr>        <chr>  
    ## 1 inconsistent_values age_at_baseline numeric greater_than age_at_onset numeric
    ## 2 inconsistent_values baseline_date   date    lower_than   death_date   date

#### Out of range values

``` r
als_data_qc_mapping$range
```

    ## # A tibble: 16 × 6
    ##    qc_type variable        type        lower_value upper_value categories       
    ##    <chr>   <chr>           <chr>       <chr>       <chr>       <chr>            
    ##  1 range   p1              numeric     1           4           <NA>             
    ##  2 range   p2              numeric     1           4           <NA>             
    ##  3 range   p3              numeric     1           4           <NA>             
    ##  4 range   p4              numeric     1           4           <NA>             
    ##  5 range   p5              numeric     1           4           <NA>             
    ##  6 range   p6              numeric     1           4           <NA>             
    ##  7 range   p7              numeric     1           4           <NA>             
    ##  8 range   p8              numeric     1           4           <NA>             
    ##  9 range   p9              numeric     1           4           <NA>             
    ## 10 range   x1r             numeric     1           4           <NA>             
    ## 11 range   x2r             numeric     1           4           <NA>             
    ## 12 range   x3r             numeric     1           4           <NA>             
    ## 13 range   age_at_baseline numeric     20          100         <NA>             
    ## 14 range   age_at_onset    numeric     20          100         <NA>             
    ## 15 range   death_date      date        2000-01-01  2022-01-01  <NA>             
    ## 16 range   onset           categorical <NA>        <NA>        bulbar, respirat…

### `qc_data` function

`qc_data` takes as arguments the data to be quality controlled and the
QC mapping containing the tests to be applied.

``` r
qc_data(als_data, als_data_qc_mapping)[,c("subjid","age_at_onset","onset","baseline_date","death_date","finding")]
```

    ## # A tibble: 13 × 6
    ##    subjid age_at_onset onset  baseline_date death_date finding                  
    ##    <chr>  <chr>        <chr>  <chr>         <chr>      <chr>                    
    ##  1 30     80           bulbar 2005-11-11    2015-05-30 subjid variable is dupli…
    ##  2 30     48           bulbar 2008-02-27    2014-07-05 subjid variable is dupli…
    ##  3 11     46           bulbar 2007-03-09    2016-09-26 variable p8 is missing   
    ##  4 12     45           bulbar 2005-01-11    2010-06-20 variable p8 is missing   
    ##  5 13     77           bulbar 2010-12-22    2019-07-05 variable p8 is missing   
    ##  6 6      68           spinal 2007-04-30    2010-05-08 variable x2r is out of r…
    ##  7 15     376          spinal 2005-09-15    2010-07-20 variable age_at_onset is…
    ##  8 28     -23          bulbar 2002-05-11    2017-11-09 variable age_at_onset is…
    ##  9 3      80           spinal 2007-01-27    9999-12-30 variable death_date is o…
    ## 10 2      77           bulba  2003-07-03    2019-06-24 variable onset is not a …
    ## 11 8      62           spinal 2002-12-13    2018-05-04 variables age_at_baselin…
    ## 12 15     376          spinal 2005-09-15    2010-07-20 variables age_at_baselin…
    ## 13 24     67           bulbar 2006-08-12    2002-12-02 variables baseline_date …

This will return a table with all the findings. If you want to save it,
you can specify the path to be saved in `output_file`.
