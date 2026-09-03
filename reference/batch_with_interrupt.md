# Execute batch operation with interrupt handling and progress

Processes a list of items with progress tracking and graceful interrupt
handling. If interrupted, reports how many items were completed before
stopping.

## Usage

``` r
batch_with_interrupt(items, fun, label_fun = NULL)
```

## Arguments

- items:

  List or vector of items to process.

- fun:

  Function to apply to each item. Receives (item, index).

- label_fun:

  Optional function to generate label for each item.

## Value

List of results (NULL for items not processed due to interrupt).
