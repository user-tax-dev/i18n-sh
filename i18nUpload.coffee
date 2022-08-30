#!/usr/bin/env coffee

> @rmw/thisdir
  path > join dirname
  fs/promises > opendir readFile
  @rmw/pool:Pool
  ./git > ROOT STATIC PWD
  ./ossLi.mjs
  @iuser/ossput


< (bucket, ver)=>
  put = await ossput ossLi, bucket

  I18N = join ROOT,'json'

  pool = Pool 20

  for await {name} from await opendir I18N
    if name.endsWith '.json'
      name = name[..-6]
      await pool put, ver+'/'+name, (await readFile join(STATIC,name)), 'text/plain'
  await pool.done
  return


