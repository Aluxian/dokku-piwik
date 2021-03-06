# dokku-piwik

This is a simple setup of Piwik and a few plugins, suitable for running on [dokku](http://dokku.viewdocs.io/dokku/).

Piwik Version: *2.16.1*

Additional plugins:
- [Custom Dimensions 0.1.4](https://plugins.piwik.org/CustomDimensions)
- [Platforms Report 1.0.4](https://plugins.piwik.org/PlatformsReport)

Note that some plugins are disabled by default.

## Deploy

Install mariadb and create the app and its db:

```
dokku apps:create piwik
dokku plugin:install https://github.com/dokku/dokku-mariadb.git mariadb
dokku mariadb:create piwik
dokku mariadb:link piwik piwik
```

Now push piwik:

```
git clone git@github.com:Aluxian/dokku-piwik.git
cd dokku-piwik
vim config.ini.php # edit settings if needed
git remote add dokku dokku@yourserver.me:piwik
git push dokku master
```

Start the archiver process, too (this step is only needed once):

```
dokku ps:scale piwik archive=1
```

## Config

The config files have been customised to my needs, make sure you edit it before launching the app and customise it to your own needs. Note that some settings made from the Piwik web UI (e.g. changing plugins) won't persist between launches unless you add those changes to this repository as well.

These env vars are available:

- **DB_HOST:** your database's host
- **DB_USERNAME:** your database's username
- **DB_PASSWORD:** your database's password
- **DB_NAME:** your database's name
- **NOREPLY_EMAIL:** used by piwik to send emails (using postmark)
- **SECRET_TOKEN:** secret secret
- **POSTMARK_TOKEN:** used as an stmp provider for emails
- **TRUSTED_HOST_X:** where `X` can be anything; for example, you can set `TRUSTED_HOST_1=app.com` and `TRUSTED_HOST_2=my.app.com`
- **FORCE_SSL:** this is either `1` or `0` (default)

## Archiving

The Procfile includes a process responsible for running the `core:archive` task. It's set to run every 3600 seconds by default, but this interval can be changed using the env var ARCHIVE_INTERVAL.

## Plugins

You can use composer to install additional plugins. See https://github.com/composer/installers and the examples in `composer.json`.

## License

MIT
