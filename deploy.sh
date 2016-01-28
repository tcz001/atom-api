if [ "$ATOM_API_ENV" = "production" ]
then
    /bin/bash --login -c "rvm use 2.2.1 && cap production deploy branch=release"
else
    /bin/bash --login -c "rvm use 2.2.1 && cap staging deploy branch=release"
fi
