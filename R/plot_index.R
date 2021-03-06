#' Create main index analysis plots
#'
#' @param index_output the output from running index_analysis
#' @param type the type of value to plot between exon and introns (default: "tstat")
#'
#' @return None
#' @export
#'
#' @examples
plot_index <- function(index_output, type = c("tstat", "logfc")) {
    # check object validity
    stopifnot(
        !is.null(index_output$category),
        !is.null(index_output$decide.tests),
        !is.null(index_output$dges),
        !is.null(index_output$voom),
        !is.null(index_output$tops)
    )

    type <- match.arg(type)

    par(mfrow = c(1, 2))
    on.exit(par(mfrow = c(1, 1)))

    # TODO: Sort out the levels to remove these manual reordering
    bar_col <- RColorBrewer::brewer.pal(9, "Paired")
    bar_col <- bar_col[c(3:4, 7:8, 5:6, 1:2, 9)]

    # assign colours to points, every point should only belong to one category
    categories <- index_output$category
    categories <- factor(
        categories,
        levels = c("Mixed+-", "Mixed-+", "Intron-", "Intron+", "Exon-", "Exon+", "+", "-", "")
    )
    point_col <- c(bar_col)[categories]

    category_counts <- sapply(
        setdiff(levels(categories), ""),
        function(x) {
            sum(categories == x)
        }
    )

    barplot(
        category_counts,
        col = bar_col,
        las = 2,
        main = "index Categories"
    )

    if (type == "tstat") {
        plot(
            index_output$tops$intron$t,
            index_output$tops$exon$t,
            pch = 20,
            col = point_col,
            main = "t-statistic",
            xlab = "Intron t-statistic",
            ylab = "Exon t-statistic"
        )
    } else if (type == "logfc") {
        plot(
            index_output$tops$intron$logFC,
            index_output$tops$exon$logFC,
            pch = 20,
            col = point_col,
            main = "logFC",
            xlab = "Intron logFC",
            ylab = "Exon logFC"
        )
    }
    abline(a = 0, b = 1, col = "#BBBBBB", lwd = 2)
    par(mfrow = c(1, 1))
}
