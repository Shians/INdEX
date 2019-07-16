# INtron differences to EXon (index)

## Installation

```r
devtools::install_github("shians/index")
```

## Example usage

```r
library(index)

exon <- readRDS(system.file("extdata/exon_dge.Rds", package = "index"))
intron <- readRDS(system.file("extdata/intron_dge.Rds", package = "index"))
group <- readRDS(system.file("extdata/group.Rds", package = "index"))

x <- index_analysis(exon, intron, group)
plot_voom(x)
plot_lcpm_cor(x)
plot_index(x)
```
