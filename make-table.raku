#!/usr/bin/rakudo

# vim: ft=perl6
# vim: shiftwidth=2

my $source_file = './input-event-codes.h'.IO;
my $sink_file = './key_codes.rs'.IO;

my $out_fh = open $sink_file, :w;

$out_fh.print: "\n";
$out_fh.print: '#[derive(Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Clone, Copy, FromStr)]' ~ "\n";
$out_fh.print: "pub enum KeyCode \{\n";

for $source_file.lines {
  if (/\#define\s+KEY_(\w+)\s+(<[xabcdef\d]>+)/) {
    my $name = $0;
    my $number = $1.Int;
    
    unless ($name ~~ ('RESERVED' | 'MAX')) {
      if ($name ~~ /^\d.*/) {
        $name = "K$name";
      }
      
      $out_fh.print: "  $name = $number,\n";
    }
  }
}

$out_fh.print: "\}\n\n";
close($out_fh);

