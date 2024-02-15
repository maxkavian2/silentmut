# SilentMut - a package for silent mutations generation in ORFs (and beyond).

SilentMut is an R package designed to generate silent mutations in protein-coding DNA sequences, i.e. open reading frames (ORF). SilentMut takes an input sequence and replaces it by a random selection of synonymous codons, assuming that the first codon marks the ribosomic reading frame.

Input sequences can be degenerated (or incomplete), i.e. they may be written according to the current coding standards [^1][^2][^3][^4][^5][^6][^7].


A sequence is degenerated or incomplete when it includes more symbols than ATCG. When this capability is enabled, the selection of codons might change its meaning and the mutations would not be silent. Ensure that the sequence contains ATCG only to make them silent!

SilentMut utilizes the standard genetic code published in the ```BiocManager``` package, which is included in the list of dependencies. Nonetheless, custom genetic codes can be referred from the R environment. By doing so other substitution criteria could be used: the genetic code is stored in the environment as a ```data.frame``` typically holding a column named ```aa```, which stands for the aminoacid residue, and a column named ```sq```, for the codon sequence. Another column, named in a different way, may be attached to the genetic code, e.g.  ```polarity```, holding the polarity of the residue side-chain. If this other column is specified, the substitution rule will change as to set up the selection for random codons according to their residue polarity rather than their residue identity.

SilentMut also contains a function that restricts the substitution to the global alignment between two sequences.


[^1]: Biochem. J., 1985, 229, 281-286 
[^2]: Eur. J. Biochem., 1985, 150, 1-5 
[^3]: J. Biol. Chem., 1986, 261, 13-17 
[^4]: Mol. Biol. Evol., 1986, 3, 99-108
[^5]: Nucl. Acids Res., 1985, 13, 3021-3030
[^6]: Proc. Nat. Acad. Sci. (U. S.), 1986, 83, 4-8
[^7]: Biochemical Nomenclature and Related Documents, 2nd edition, Portland Press, 1992, pp 122-126. Copyright IUBMB



