package ConsoleUtil;

sub Prompt($){
    print "$_[0]";
    return <STDIN>;
}

1;