# FREDDY
Install postgres server and postgresql-server-dev package.
create a db demodb and a user demouser.
install faiss https://github.com/facebookresearch/faiss
Download movies.list.gz from ftp://ftp.fu-berlin.de/pub/misc/movies/database
create imdb folder and copy the loader.sh to same folder.
copy movies.list.gz to imdb folder and unzip it to imdb-to-sql/db_dump folder within the same path, and run the loader.sh script.
This will populate movies table with the right data, verify it by select count(*) from movies;
Follow index creation steps from https://github.com/guenthermi/postgres-word2vec but replace the loader(python) files by the one provided in this repo.
Now UDFs should be available and can be run.
