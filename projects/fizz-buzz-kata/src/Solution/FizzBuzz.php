<?php declare(strict_types=1);

namespace Andezdev\TddKatas\FizzBuzzKata\Solution;

final class FizzBuzz
{
    public function execute(int $int): void
    {
        if ($int % 15 === 0) {
            print 'FizzBuzz\n';
        } else if ($int % 3 === 0) {
            print 'Fizz\n';
        } else if ($int % 5 === 0) {
            print 'Buzz\n';
        } else {
            print $int . '\n';
        }
    }
}