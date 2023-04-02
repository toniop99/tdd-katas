#!/usr/bin/env php
<?php
require __DIR__ . '/../vendor/autoload.php';

use Andezdev\TddKatas\Console\ExecuteTestCommand;
use Symfony\Component\Console\Application;

$application = new Application();

// ... register commands
$application->add(new ExecuteTestCommand());


try {
    $application->run();
} catch (Exception $e) {
}