filename <- 'Edgeworth_benchmarks.pdf'

plot_error <- function(n, m, alt){
  u_max <- n*m
  all_values <- seq_len(u_max)
  actual <- orig <- newval <- rep(NA_real_, u_max)
  MAX_ITER <- 10000
  successes <- 0
  to_pull <- seq_len(n+m)

  for(i in seq_len(10000)){
    v1 <- sample(to_pull, n)
    v2 <- to_pull[-v1]
    ores <- wilcox.test(v1, v2, alternative=alt, exact=FALSE)
    if(!is.na(orig[ores$statistic + 1])) next

    s <- ores$statistic+1L
    orig[s] <- ores$p.value
    actual[s] <- wilcox.test(v1, v2, alternative=alt, exact=TRUE)$p.value
    newval[s] <- new.wilcox(v1, v2, alternative=alt, exact=FALSE)$p.value
    successes <- successes + 1L
    if( successes == length(all_values) ) break
  }
  prune <- !is.na(newval)
  plot(x=seq_len(u_max)[prune]-1, y=orig[prune]-actual[prune], col='red',
       ylab='error (p-value)', xlab='U', type='l',
       main=paste0("n=", n, ", m=", m, ' (', a, ')'))
  abline(h=0, col='black')
  lines(x=seq_len(u_max)[prune]-1, y=newval[prune]-actual[prune], col='green')
  legend("topright", legend=c("Normal", "Edgeworth"), col=c("red", 'green'), lwd=1, cex=0.75)
  #return(list(orig=orig[prune], new=newval[prune], actual=actual[prune]))
}

pdf(filename, onefile=TRUE)
layout(matrix(1:4, nrow=2))
for(a in c("greater", "less", "two.sided")){
  plot_error(50,5,a)
  plot_error(10,10,a)
  plot_error(30,30,a)
  plot_error(50,50,a)
}
dev.off(dev.list()["pdf"])
