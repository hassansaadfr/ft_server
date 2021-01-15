<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wordpress' );

/** MySQL hostname */
define( 'DB_HOST', '127.0.0.1' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         't[OAx+YIdU KtoE4L_[T$B:j$C!D?[M`eRAVpWgR5@8RtT[DY6[w_Eyf]|(Olu P' );
define( 'SECURE_AUTH_KEY',  '7F46}!8adN%,`T=mI:ab&L&,#&vBRT dO|B9D^9nWQ[1DSU`.e:j.nB(f#-X=-iI' );
define( 'LOGGED_IN_KEY',    'L^gt.GA8eTfnAPy@:!#/TXHzDvQX)),46S:hp/nYr1QZMc^Ze;v$dYH7pJ`M.7.Y' );
define( 'NONCE_KEY',        'FV)@E+m{mkvxSJF>WeS}uFc3<+Z>NP2I@_l~5M.}i?^DEQ~&K!*4:R59pJ V~dEK' );
define( 'AUTH_SALT',        'vnrtL)KZGPE4YxvdWE>dwc>!xmT[,aIP?t0w#`cjpfe P2M]5Z6,SSy !toq#${P' );
define( 'SECURE_AUTH_SALT', 'c~vpH< -|(FOW2{C?/oF%rPd@0yMAS,xz:w*U?Sn%7e-@3&R@L2g`0zX) ]cTX`,' );
define( 'LOGGED_IN_SALT',   'Tl4$ppjntiX4@*MS8^/_ZQQB<F_bm>-MHs*B&59FwCtr3vnnPaeg@LD|S}ph4P?^' );
define( 'NONCE_SALT',       '-%9bR`Vd)MS{Z?#}wnSDVgq2Y4[>=?)4lS4S~`D]v?/.Vt&f-9^}.DPY/BGq0^)o' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

