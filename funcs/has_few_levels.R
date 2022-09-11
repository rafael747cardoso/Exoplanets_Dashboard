
### To filter by the number of levels

has_few_levels = function(x){
    if(length(unique(x)) < 9){
        TRUE
    } else{
        FALSE
    }
}

