# genomics

Popper pipeline that guides you through [this](https://jasonjwilliamsny.github.io/wrangling-genomics/01-automating_a_workflow.html) tutorial.

In this case Popper makes sure that the required files 
and the required tools are downloaded, then it executes 
all the indicated steps in the tutorial and copies the 
output files to a visualize folder so you can visualize
them using [GVI](http://software.broadinstitute.org/software/igv/home)

It also checks the output vcf file with a local vcf generated using
a Mac. If they match, it shows [true] as an output. [false] otherwise
The concordance is made using the tool [SnpSift](http://snpeff.sourceforge.net/SnpSift.html)