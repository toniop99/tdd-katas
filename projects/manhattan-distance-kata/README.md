---
title: manhattan distance kata
tags: [tdd, starter, pair-programming, solid]
---

# Manhattan Distance Kata
[Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry) is the distance between two points in a grid 
calculated by only taking a vertical and/or horizontal path.

Write a function that returns the Manhattan Distance between the two points. You have the following interface:

```php
interface ManhattanDistance
{
    public function calculate(Point $a, Point $b): int;
}
```

## Rules
- The class Point is immutable (its state cannot be changed after instantiation)
- The class Point has no Getters
- The class Point has no public properties (i.e. the internal state cannot be read from outside the class).

**Happy coding**!