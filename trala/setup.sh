if [ -z "$1" ]
then
    root_dir=".."
else
    root_dir="$1"
fi

mkdir -p $root_dir/user/trala
test -f $root_dir/user/trala/configuration.yml && rm $root_dir/trala/configuration.default.yml && echo 'TraLa configuration already exists' || mv $root_dir/trala/configuration.default.yml $root_dir/user/trala/configuration.yml