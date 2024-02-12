# R Patches
Known bugs that I'm working on improving in R. Feel free to submit an issue on this repo and I'll add more improvements to my queue. 
This list is partly for my own reference so I don't forget what I was planning to work on.

## Patches submitted
- [#18480](https://bugs.r-project.org/show_bug.cgi?id=18480): Non-recursive reimplementation of `dendrapply` that also allows for different tree traversal methods.
- [#18655](https://bugs.r-project.org/show_bug.cgi?id=18655): Improvements for `*wilcox` functions when populations are larger than 50, reduces memory scaling.

## Known Issues
- [`*signrank` functions hang for large n](https://aakinshin.net/posts/signrank-limitations/): Happens around `n>=1000`. Solution is likely to implement an `exact=c(TRUE,FALSE)` argument with a large population size approximation (e.g., Edgeworth).
- [`wilcox.test` produces incorrect median estimates](https://aakinshin.net/posts/r-hodges-lehmann-problems/): `$estimate` is wildly incorrect in presence of zeros, ties, or degeneracy. This issue has been addressed and fixed in DescTools ([link](https://github.com/AndriSignorell/DescTools/issues/97)), but still needs to be fixed in base.
- [`wilcox.test` inflates estimated p-values at tails](https://aakinshin.net/posts/r-mann-whitney-incorrect-p-value/): if either population is large (>=50), p-values will be inflated due to normal approximation. [Edgeworth expansion](https://aakinshin.net/posts/mw-edgeworth/) should be implemented for improved accuracy.

