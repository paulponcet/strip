# strip: lighten R model outputs

The strip function deletes components of R model outputs that are useless for specific purposes, such as predict[ing], print[ing], summary[zing], etc. 

The idea is to prevent the size of the model output to grow with the size of the training dataset. 
This is useful if one has to save the output for later use while limiting its size on disk. 

The birth of this package originates with Nina Zumel's post [`Trimming the Fat from glm() Models in R'](http://www.win-vector.com/blog/2014/05/trimming-the-fat-from-glm-models-in-r/) on Win-Vector Blog. 


## Installation

You can install strip from GitHub with:

```R
# install.packages("devtools")
devtools::install_github("paulponcet/strip")
```
