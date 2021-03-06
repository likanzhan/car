\name{densityPlot}
\alias{densityPlot}
\alias{densityPlot.default}
\alias{densityPlot.formula}
\alias{adaptiveKernel}

\title{
Nonparametric Density Estimates
}
\description{
\code{densityPlot} contructs and graphs nonparametric density estimates, possibly conditioned on a factor.
By default it uses the standard \R{} \code{\link{density}} function or optionally \code{adaptiveKernel}.
}

\usage{
densityPlot(x, ...)

\method{densityPlot}{default}(x, g, method=c("kernel", "adaptive"), 
    bw=if (method == "adaptive") bw.nrd0 else "SJ", adjust=1,
    kernel, xlim, ylim, normalize=FALSE,
    xlab=deparse(substitute(x)), ylab="Density", 
    col=palette(), lty=seq_along(col), lwd=2, grid=TRUE,
    legend.location="topright", legend.title=deparse(substitute(g)), show.bw=FALSE,
    rug=TRUE, ...) 
    
\method{densityPlot}{formula}(formula, data = NULL, subset, 
    na.action = NULL, xlab, ylab, ...)

adaptiveKernel(x, kernel=dnorm, bw=bw.nrd0, adjust=1.0, n=500, 
    from, to, cut=3, na.rm=TRUE)
}


\arguments{
  \item{x}{a numeric variable, the density of which is estimated.}
  \item{g}{an optional factor to divide the data.}
  \item{formula}{an \R{} model formula, of the form \code{~ variable} to estimate the unconditional
    density of \code{variable}, or \code{variable ~ factor} to estimate the density of \code{variable}
    within each level of \code{factor}.}
  \item{data}{an optional data frame containing the data.}
  \item{subset}{an optional vector defining a subset of the data.}
  \item{na.action}{a function to handle missing values; defaults to the value of the \R{} \code{na.action} option,
    initially set to \code{\link{na.omit}}.}
  \item{method}{either \code{"adaptive"} (the default) for an adaptive-kernel estimate or \code{"kernel"} for a fixed-bandwidth kernel estimate.}
  \item{bw}{the geometric mean bandwidth for the adaptive-kernel or bandwidth of the kernel density estimate(s). Must be a numerical value 
    or a function to compute the bandwidth (default \code{\link{bw.nrd0}}) for the adaptive
    kernel estimate; for the kernel estimate, may either the quoted name of a rule to
    compute the bandwidth, or a numeric value. If plotting by groups, \code{bw}
    may be a vector of values, one for each group. See \code{\link{density}} and \code{\link{bw.SJ}} for details of the kernel estimator.}
  \item{adjust}{a multiplicative adjustment factor for the bandwidth; the default, \code{1}, indicates no adjustment;
    if plotting by groups, \code{adjust} may be a vector of adjustment factors, one for each group. The default bandwidth-selection rule tends to give a value that's too large if
    the distribution is asymmetric or has multiple modes; try setting \code{adjust} <  1, particularly for the adaptive-kernel estimator.}
  \item{kernel}{for \code{densityPlot} this is the name of the kernel function for the kernel estimator (the default is \code{"gaussian"}, see \code{\link{density}});
    or a kernel function for the adaptive-kernel estimator (the default is \code{dnorm}, producing the Gaussian kernel). 
    For \code{adaptivekernel} this is a kernel function, defaulting to \code{dnorm}, which is the Gaussian kernel (standard-normal density).}
  \item{xlim, ylim}{axis limits; if missing, determined from the range of x-values at which the densities are estimated and the estimated densities.}
  \item{normalize}{if \code{TRUE} (the default is \code{FALSE}), the estimated densities are rescaled to integrate approximately to 1; particularly useful if the
    density is estimated over a restricted domain, as when \code{from} or \code{to} are specified.}
  \item{xlab}{label for the horizontal-axis; defaults to the name of the variable \code{x}.}
  \item{ylab}{label for the vertical axis; defaults to \code{"Density"}.}
  \item{col}{vector of colors for the density estimate(s); defaults to the color \code{\link{palette}}.}
  \item{lty}{vector of line types for the density estimate(s); defaults to the successive integers, starting at 1.}
  \item{lwd}{line width for the density estimate(s); defaults to 2.}
  \item{grid}{if \code{TRUE} (the default), grid lines are drawn on the plot.}
  \item{legend.location}{location for the legend when densities are plotted for several groups; defaults to
    \code{"upperright"}; see \code{\link{legend}}.}
  \item{legend.title}{label for the legend, which is drawn if densities are plotted by groups; the default is
    the name of the factor {g}.}
  \item{n}{number of equally spaced points at which the adaptive-kernel estimator is evaluated; the default is \code{500}.}
  \item{from, to, cut}{the range over which the density estimate is computed; the default, if missing, is \code{min(x) - cut*bw, max(x) + cut*bw}.}
  \item{na.rm}{remove missing values from \code{x} in computing the adaptive-kernel estimate? The default is \code{TRUE}.}
  \item{show.bw}{if \code{TRUE}, show the bandwidth(s) in the horizontal-axis label or (for multiple groups)
    the legend; the default is \code{FALSE}.}
  \item{rug}{if \code{TRUE} (the default), draw a rug plot (one-dimentional scatterplot) at the bottom of the density estimate.}
  \item{\dots}{arguments to be passed down.}
}

\value{
\code{densityPlot} invisibly returns the \code{"density"} object computed (or list of \code{"density"} objects) and draws a graph. 
\code{adaptiveKernel} returns an object of class \code{"density"}
(see \code{\link{density})}.
}

\references{
W. N. Venables and B. D. Ripley (2002) \emph{Modern Applied Statistics with S}. New York: Springer.

B.W. Silverman (1986) \emph{Density Estimation for Statistics and Data Analysis}. London: Chapman and Hall.
}

\author{
John Fox \email{jfox@mcmaster.ca}
}

\seealso{
\code{\link{density}}, \code{\link{bw.SJ}}, \code{\link{plot.density}}
}

\examples{
densityPlot(~ income, show.bw=TRUE, data=Prestige)
densityPlot(~ income, method="adaptive", show.bw=TRUE, data=Prestige)
densityPlot(~ income, method="adaptive", from=0, normalize=TRUE, show.bw=TRUE, data=Prestige)

densityPlot(income ~ type, method="adaptive", data=Prestige)

plot(adaptiveKernel(UN$infant.mortality, from=0, adjust=0.75), col="magenta")
lines(density(na.omit(UN$infant.mortality), from=0, adjust=0.75), col="blue")
rug(UN$infant.mortality, col="cyan")
legend("topright", col=c("magenta", "blue"), lty=1, 
  legend=c("adaptive kernel", "kernel"), inset=0.02)
}

\keyword{hplot}
