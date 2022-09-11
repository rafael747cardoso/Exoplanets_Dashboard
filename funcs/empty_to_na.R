
### Replace empty strings with NA in a vector

empty_to_na = function(x){
    
    x_new = ifelse(x == "",
                   NA,
                   x)
    return(x_new)
}



