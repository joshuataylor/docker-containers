<?php

/**
 * Helper function to get default configuration from either
 * local file or environment variable. If none of those are
 * not found then default to the provided.
 */
function GetConfig($file, $env, $default) {
  $dir = '/etc/config';

  if (file_exists($dir . '/' . $file)) {
    return str_replace("\n", '', file_get_contents($dir . '/' . $file));
  }

  if (getenv($env)) {
    return getenv($env);
  }

  return $default;
}
