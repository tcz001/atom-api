if [ "$ATOM_API_ENV" = "production" ]
then
    /bin/bash --login -c "rvm use 2.2.1 && cap production passenger:restart"
else
    /bin/bash --login -c "rvm use 2.2.1 && cap staging passenger:restart"
fi
