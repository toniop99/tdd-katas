<?php declare(strict_types=1);

namespace Andezdev\TddKatas\Bin\Commands;

use Jawira\CaseConverter\Convert;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\Question;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Process\Process;

final class GenerateKataStructureCommand extends Command
{
    private string $baseDirectory;
    private Filesystem $filesystem;

    public function __construct(string $name = null)
    {
        parent::__construct($name);

        $this->baseDirectory = dirname(__FILE__, 3);
        $this->filesystem = new Filesystem();
    }

    protected function configure(): void
    {
        $this
            ->setName('generate:kata-skeleton')
            ->setHelp('This command allows you generate a new kata basic skeleton...')
            ->setDescription('Execute the test suite.')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $helper = $this->getHelper('question');

        $question = new Question('Please enter the kata name: ');
        $kataNameConverter = new Convert($helper->ask($input, $output, $question));

        if ($this->filesystem->exists($this->baseDirectory . '/projects/' . $kataNameConverter->toKebab())) {
            $output->writeln('<error>The kata already exists</error>');
            return Command::FAILURE;
        }

        $createSkeletonProcess = new Process(
            [
                'bin/shell/generate-kata-skeleton.bash',
                $kataNameConverter->toKebab(),
                $kataNameConverter->toPascal(),
                $this->baseDirectory . '/projects',
            ],
            $this->baseDirectory
        );

        var_dump($createSkeletonProcess->getCommandLine());

        $createSkeletonProcess->run(function ($type, $buffer) use ($output) {
            $output->write($buffer);
        });

        return Command::SUCCESS;
    }
}