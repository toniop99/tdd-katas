<?php

declare(strict_types=1);


namespace Andezdev\TddKatas\FizzBuzzKata\Tests;

use Andezdev\TddKatas\FizzBuzzKata\Kata;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class KataTest extends TestCase
{
    #[Test]
    public function dummy(): void
    {
        $kata = new Kata();
        $this->assertInstanceOf(Kata::class, $kata);
    }
}
