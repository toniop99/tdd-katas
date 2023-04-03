<?php declare(strict_types=1);

namespace Andezdev\TddKatas\Bin\Commands;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\ChoiceQuestion;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Process\Process;
use function Lambdish\Phunctional\flatten;
use function Lambdish\Phunctional\map;

final class ExecuteTestCommand extends Command
{
    private const TEST_SUITES = ['test', 'solution'];
    private string $baseDirectory;
    private Finder $finder;

    public function __construct(string $name = null)
    {
        parent::__construct($name);

        $this->baseDirectory = dirname(__FILE__, 3);
        $this->finder = new Finder();
    }

    protected function configure(): void
    {
        $this
            ->setName('test')
            ->setHelp('This command allows you to create a user...')
            ->setDescription('Execute the test suite.')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $projectDirectories = $this->finder
            ->directories()
            ->in($this->baseDirectory . '/projects')
            ->depth(0);

        $projectsDirectoriesNames = map(
            fn($projectDirectory) => $projectDirectory->getFilename(),
            $projectDirectories
        );

        $projectSelectionName = $this->getHelper('question')->ask(
            $input,
            $output,
            new ChoiceQuestion(
                'Select the project to execute the test suite',
                flatten($projectsDirectoriesNames)
        ));

        $testsuite = $this->getHelper('question')->ask(
            $input,
            $output,
            new ChoiceQuestion(
                'Select the test suite',
                self::TEST_SUITES,
                0
            ));

        $this->executeTestSuite(
            $testsuite,
            $this->baseDirectory . '/projects/' . $projectSelectionName,
            $output
        );

        return Command::SUCCESS;
    }

    private function executeTestSuite(string $testsuite, string $projectPath, OutputInterface $output): void
    {
        $process = new Process(
            [
                'vendor/bin/phpunit',
                '--colors=always',
                '--testsuite=' . $testsuite,
                '--configuration=' . $projectPath . '/phpunit.xml'
            ],
            $this->baseDirectory
        );

        $process->run(function ($type, $buffer) use ($output) {
            $output->write($buffer);
        });
    }
}