# support.and.confidence
Just an example of my own function to get support and confidence, essential when working with associaton rules.

## Some comments about this function

This function expects the dataset to had been preprocessed conveniently,
that is, with all the due values discretized and factorized.
In other words, that the dataset has been treated the same way
it is when **apriori** or **eclat** are used, for example.

Just two types of data structure are considered: **data frames** 
and **transactions**. Neither exception handling nor warnings have
been included if **data** argument type is not supported.

## Algunos comentarios sobre la función:

Supongo que a esta función le llega el dataset convenientemente
preprocesado, esto es, con valores discretizados o factorizados.
Es decir, que ha sido tratado de igual manera que se trata
previo uso a la función **apriori** o **eclat**, por ejemplo.

Solo contemplo dos tipos: **data frames** y **transactions**. 
No incluyo avisos ni excepciones en caso de que el tipo de "data" 
pasado no esté soportado.
