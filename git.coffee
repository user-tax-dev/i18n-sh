#!/usr/bin/env coffee

> isomorphic-git:GIT
  @rmw/thisdir
  path > dirname join
  fs

< PWD = thisdir(import.meta)
< ROOT = dirname PWD
< NAME = (await GIT.getConfig({
  dir: ROOT
  path: 'remote.origin.url'
  fs
})).split('/').pop(0)[..-5]

< git = new Proxy(
  {}
  get:(_,attr)=>
    (o)=>
      GIT[attr](
        {
          dir:STATIC
          fs
          ...o
        }
      )
)

< STATIC = join(
  ROOT
  'static'
)
