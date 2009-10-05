use inc::Module::Install;
name 'IO-File-WithPath';
all_from 'lib/IO/File/WithPath.pm';

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
author_tests 'xt';
use_test_base;
auto_include;
WriteAll;
