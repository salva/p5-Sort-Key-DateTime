use 5.008000;
use ExtUtils::MakeMaker;

WriteMakefile( NAME          => 'Sort::Key::DateTime',
	       VERSION_FROM  => 'lib/Sort/Key/DateTime.pm',
	       PREREQ_PM     => { 'DateTime'   => 0.28,
				  'Sort::Key'  => 0.01,
				  'Test::More' => 0.54 },
	       ABSTRACT_FROM => 'lib/Sort/Key/DateTime.pm',
	       AUTHOR        => 'Salvador Fandino <sfandino@yahoo.com>');