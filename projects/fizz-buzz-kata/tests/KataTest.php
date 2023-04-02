<?php

declare(strict_types=1);


namespace Andezdev\TddKatas\FizzBuzzKata\Tests;

use Andezdev\TddKatas\FizzBuzzKata\Solution\FizzBuzz;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class KataTest extends TestCase
{
    #[Test]
    public function acceptance_criteria(): void
    {
        $fizzBuzz = new FizzBuzz();

        $fizzBuzz->execute(1);
        $this->assertEquals('1\n', $this->getActualOutputForAssertion());

        $fizzBuzz->execute(3);
        $this->assertEquals('1\nFizz\n', $this->getActualOutputForAssertion());

        $fizzBuzz->execute(5);
        $this->assertEquals('1\nFizz\nBuzz\n', $this->getActualOutputForAssertion());

        $fizzBuzz->execute(15);
        $this->assertEquals('1\nFizz\nBuzz\nFizzBuzz\n', $this->getActualOutputForAssertion());
    }
}
