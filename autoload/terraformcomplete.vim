" terraformcomplete.vim - context-aware Terraform/HCL omni-completion for vim-hue
" Maintainer: Adnan Hodzic <adnan@hodzic.org>
" License: GPLv3

if exists('g:loaded_terraformcomplete')
  finish
endif
let g:loaded_terraformcomplete = 1

let s:top_blocks = [
  \ {'word': 'resource',  'kind': 'b', 'menu': 'block: resource "<type>" "<name>" { ... }'},
  \ {'word': 'data',      'kind': 'b', 'menu': 'block: data "<type>" "<name>" { ... }'},
  \ {'word': 'variable',  'kind': 'b', 'menu': 'block: variable "<name>" { ... }'},
  \ {'word': 'output',    'kind': 'b', 'menu': 'block: output "<name>" { ... }'},
  \ {'word': 'locals',    'kind': 'b', 'menu': 'block: locals { ... }'},
  \ {'word': 'module',    'kind': 'b', 'menu': 'block: module "<name>" { ... }'},
  \ {'word': 'provider',  'kind': 'b', 'menu': 'block: provider "<name>" { ... }'},
  \ {'word': 'terraform', 'kind': 'b', 'menu': 'block: terraform { ... }'},
  \ {'word': 'moved',     'kind': 'b', 'menu': 'block: moved { from = ... to = ... }'},
  \ {'word': 'import',    'kind': 'b', 'menu': 'block: import { to = ... id = ... }'},
  \ {'word': 'check',     'kind': 'b', 'menu': 'block: check "<name>" { ... }'},
  \ {'word': 'removed',   'kind': 'b', 'menu': 'block: removed { from = ... }'},
  \ ]

let s:keywords_and_types = [
  \ {'word': 'count',                 'kind': 'k', 'menu': 'meta-argument'},
  \ {'word': 'for_each',              'kind': 'k', 'menu': 'meta-argument'},
  \ {'word': 'depends_on',            'kind': 'k', 'menu': 'meta-argument'},
  \ {'word': 'provider',              'kind': 'k', 'menu': 'meta-argument'},
  \ {'word': 'lifecycle',             'kind': 'b', 'menu': 'nested block'},
  \ {'word': 'create_before_destroy', 'kind': 'k', 'menu': 'lifecycle'},
  \ {'word': 'prevent_destroy',       'kind': 'k', 'menu': 'lifecycle'},
  \ {'word': 'ignore_changes',        'kind': 'k', 'menu': 'lifecycle'},
  \ {'word': 'replace_triggered_by',  'kind': 'k', 'menu': 'lifecycle'},
  \ {'word': 'precondition',          'kind': 'b', 'menu': 'condition block'},
  \ {'word': 'postcondition',         'kind': 'b', 'menu': 'condition block'},
  \ {'word': 'dynamic',               'kind': 'b', 'menu': 'dynamic block'},
  \ {'word': 'content',               'kind': 'b', 'menu': 'dynamic content'},
  \ {'word': 'iterator',              'kind': 'k', 'menu': 'dynamic option'},
  \ {'word': 'type',                  'kind': 'k', 'menu': 'variable option'},
  \ {'word': 'default',               'kind': 'k', 'menu': 'variable option'},
  \ {'word': 'description',           'kind': 'k', 'menu': 'var/output option'},
  \ {'word': 'sensitive',             'kind': 'k', 'menu': 'var/output option'},
  \ {'word': 'nullable',              'kind': 'k', 'menu': 'variable option'},
  \ {'word': 'ephemeral',             'kind': 'k', 'menu': 'var/output option'},
  \ {'word': 'validation',            'kind': 'b', 'menu': 'variable validation'},
  \ {'word': 'condition',             'kind': 'k', 'menu': 'validation'},
  \ {'word': 'error_message',         'kind': 'k', 'menu': 'validation'},
  \ {'word': 'value',                 'kind': 'k', 'menu': 'output value'},
  \ {'word': 'source',                'kind': 'k', 'menu': 'module/provider source'},
  \ {'word': 'version',               'kind': 'k', 'menu': 'version constraint'},
  \ {'word': 'required_version',      'kind': 'k', 'menu': 'terraform setting'},
  \ {'word': 'required_providers',    'kind': 'b', 'menu': 'terraform block'},
  \ {'word': 'backend',               'kind': 'b', 'menu': 'terraform backend'},
  \ {'word': 'cloud',                 'kind': 'b', 'menu': 'terraform cloud'},
  \ {'word': 'provisioner',           'kind': 'b', 'menu': 'resource provisioner'},
  \ {'word': 'connection',            'kind': 'b', 'menu': 'provisioner connection'},
  \ {'word': 'string',                'kind': 't', 'menu': 'type'},
  \ {'word': 'number',                'kind': 't', 'menu': 'type'},
  \ {'word': 'bool',                  'kind': 't', 'menu': 'type'},
  \ {'word': 'list',                  'kind': 't', 'menu': 'type constructor'},
  \ {'word': 'map',                   'kind': 't', 'menu': 'type constructor'},
  \ {'word': 'set',                   'kind': 't', 'menu': 'type constructor'},
  \ {'word': 'object',                'kind': 't', 'menu': 'type constructor'},
  \ {'word': 'tuple',                 'kind': 't', 'menu': 'type constructor'},
  \ {'word': 'optional',              'kind': 't', 'menu': 'object attribute modifier'},
  \ {'word': 'any',                   'kind': 't', 'menu': 'type'},
  \ {'word': 'true',                  'kind': 'v', 'menu': 'bool'},
  \ {'word': 'false',                 'kind': 'v', 'menu': 'bool'},
  \ {'word': 'null',                  'kind': 'v', 'menu': 'null'},
  \ {'word': 'var',                   'kind': 'v', 'menu': 'input variables (var.<name>)'},
  \ {'word': 'local',                 'kind': 'v', 'menu': 'local values (local.<name>)'},
  \ {'word': 'module',                'kind': 'v', 'menu': 'module outputs (module.<name>)'},
  \ {'word': 'data',                  'kind': 'v', 'menu': 'data sources (data.<type>.<name>)'},
  \ {'word': 'each',                  'kind': 'v', 'menu': 'for_each object (each.key / each.value)'},
  \ {'word': 'path',                  'kind': 'v', 'menu': 'filesystem paths (path.module / root / cwd)'},
  \ {'word': 'self',                  'kind': 'v', 'menu': 'self reference'},
  \ {'word': 'for',                   'kind': 'k', 'menu': 'for expression'},
  \ {'word': 'in',                    'kind': 'k', 'menu': 'for expression'},
  \ {'word': 'if',                    'kind': 'k', 'menu': 'conditional'},
  \ ]

let s:functions = [
  \ 'abs', 'abspath', 'alltrue', 'anytrue', 'base64decode', 'base64encode',
  \ 'base64gzip', 'base64sha256', 'base64sha512', 'basename', 'bcrypt', 'can',
  \ 'ceil', 'chomp', 'cidrhost', 'cidrnetmask', 'cidrsubnet', 'cidrsubnets',
  \ 'coalesce', 'coalescelist', 'compact', 'concat', 'contains', 'csvdecode',
  \ 'dirname', 'distinct', 'element', 'endswith', 'file', 'filebase64',
  \ 'filebase64sha256', 'filebase64sha512', 'fileexists', 'filemd5', 'fileset',
  \ 'filesha1', 'filesha256', 'filesha512', 'flatten', 'floor', 'format',
  \ 'formatdate', 'formatlist', 'indent', 'index', 'join', 'jsondecode',
  \ 'jsonencode', 'keys', 'length', 'log', 'lookup', 'lower', 'matchkeys',
  \ 'max', 'md5', 'merge', 'min', 'nonsensitive', 'one', 'parseint',
  \ 'pathexpand', 'plantimestamp', 'pow', 'range', 'regex', 'regexall',
  \ 'replace', 'reverse', 'rsadecrypt', 'sensitive', 'setintersection',
  \ 'setproduct', 'setsubtract', 'setunion', 'sha1', 'sha256', 'sha512',
  \ 'signum', 'slice', 'sort', 'split', 'startswith', 'strcontains', 'strrev',
  \ 'substr', 'sum', 'templatefile', 'textdecodebase64', 'textencodebase64',
  \ 'timeadd', 'timecmp', 'timestamp', 'title', 'tobool', 'tolist', 'tomap',
  \ 'tonumber', 'toset', 'tostring', 'transpose', 'trim', 'trimprefix',
  \ 'trimsuffix', 'trimspace', 'try', 'type', 'upper', 'urlencode', 'uuid',
  \ 'uuidv5', 'values', 'yamldecode', 'yamlencode', 'zipmap',
  \ ]

function! s:ScanTfProject() abort
  let l:dir = expand('%:p:h')
  if empty(l:dir)
    let l:dir = getcwd()
  endif
  let l:files = glob(fnameescape(l:dir) . '/*.tf', 0, 1) + glob(fnameescape(l:dir) . '/*.tofu', 0, 1)
  let l:cur = expand('%:p')

  let l:vars = {}
  let l:locals = {}
  let l:modules = {}
  let l:datas = {}
  let l:resources = {}

  let l:all_lines = copy(getline(1, '$'))
  for l:f in l:files
    if fnamemodify(l:f, ':p') !=# l:cur && filereadable(l:f)
      call extend(l:all_lines, readfile(l:f, '', 2000))
    endif
  endfor

  let l:in_locals = 0
  let l:depth = 0
  for l:line in l:all_lines
    if l:line =~# '^\s*\%(#\|//\)'
      continue
    endif

    let l:m = matchlist(l:line, '^\s*variable\s\+"\([^"]\+\)"')
    if !empty(l:m)
      let l:vars[l:m[1]] = 1
      continue
    endif

    let l:m = matchlist(l:line, '^\s*module\s\+"\([^"]\+\)"')
    if !empty(l:m)
      let l:modules[l:m[1]] = 1
      continue
    endif

    let l:m = matchlist(l:line, '^\s*data\s\+"\([^"]\+\)"\s\+"\([^"]\+\)"')
    if !empty(l:m)
      let l:datas[l:m[1]] = get(l:datas, l:m[1], {})
      let l:datas[l:m[1]][l:m[2]] = 1
      continue
    endif

    let l:m = matchlist(l:line, '^\s*resource\s\+"\([^"]\+\)"\s\+"\([^"]\+\)"')
    if !empty(l:m)
      let l:resources[l:m[1]] = get(l:resources, l:m[1], {})
      let l:resources[l:m[1]][l:m[2]] = 1
      continue
    endif

    if !l:in_locals && l:line =~# '^\s*locals\s*{'
      let l:in_locals = 1
      let l:depth = len(substitute(l:line, '[^{]', '', 'g')) - len(substitute(l:line, '[^}]', '', 'g'))
      if l:depth <= 0
        let l:in_locals = 0
      endif
      continue
    endif

    if l:in_locals
      if l:depth == 1
        let l:lm = matchlist(l:line, '^\s*\([A-Za-z0-9_-]\+\)\s*=')
        if !empty(l:lm)
          let l:locals[l:lm[1]] = 1
        endif
      endif
      let l:depth += len(substitute(l:line, '[^{]', '', 'g')) - len(substitute(l:line, '[^}]', '', 'g'))
      if l:depth <= 0
        let l:in_locals = 0
      endif
    endif
  endfor

  return {
    \ 'vars': sort(keys(l:vars)),
    \ 'locals': sort(keys(l:locals)),
    \ 'modules': sort(keys(l:modules)),
    \ 'datas': l:datas,
    \ 'resources': l:resources,
    \ }
endfunction

function! terraformcomplete#Complete(findstart, base) abort
  if a:findstart
    let l:line = getline('.')
    let l:start = col('.') - 1
    while l:start > 0 && l:line[l:start - 1] =~# '[A-Za-z0-9_-]'
      let l:start -= 1
    endwhile
    let s:tf_prefix_before = strpart(l:line, 0, l:start)
    return l:start
  endif

  let l:before = get(s:, 'tf_prefix_before', '')
  let l:proj = s:ScanTfProject()
  let l:candidates = []

  " Dot-scoped completions: var., local., module., data., each., count., path., terraform., <resource_type>.
  let l:dot_2 = matchlist(l:before, '\<data\.\([A-Za-z0-9_-]\+\)\.$')
  let l:dot_1 = matchlist(l:before, '\<\([A-Za-z0-9_-]\+\)\.$')

  if !empty(l:dot_2)
    let l:dtype = l:dot_2[1]
    for l:dname in sort(keys(get(l:proj.datas, l:dtype, {})))
      call add(l:candidates, {'word': l:dname, 'kind': 'd', 'menu': 'data.' . l:dtype})
    endfor
  elseif !empty(l:dot_1)
    let l:ns = l:dot_1[1]
    if l:ns ==# 'var'
      for l:v in l:proj.vars
        call add(l:candidates, {'word': l:v, 'kind': 'v', 'menu': 'variable'})
      endfor
    elseif l:ns ==# 'local'
      for l:l in l:proj.locals
        call add(l:candidates, {'word': l:l, 'kind': 'v', 'menu': 'local value'})
      endfor
    elseif l:ns ==# 'module'
      for l:m in l:proj.modules
        call add(l:candidates, {'word': l:m, 'kind': 'm', 'menu': 'module'})
      endfor
    elseif l:ns ==# 'data'
      for l:dt in sort(keys(l:proj.datas))
        call add(l:candidates, {'word': l:dt, 'kind': 'd', 'menu': 'data source type'})
      endfor
    elseif l:ns ==# 'each'
      let l:candidates = [
        \ {'word': 'key',   'kind': 'v', 'menu': 'for_each map key / set member'},
        \ {'word': 'value', 'kind': 'v', 'menu': 'for_each value'},
        \ ]
    elseif l:ns ==# 'count'
      let l:candidates = [{'word': 'index', 'kind': 'v', 'menu': '0-based count index'}]
    elseif l:ns ==# 'path'
      let l:candidates = [
        \ {'word': 'module', 'kind': 'v', 'menu': 'current module directory'},
        \ {'word': 'root',   'kind': 'v', 'menu': 'root module directory'},
        \ {'word': 'cwd',    'kind': 'v', 'menu': 'current working directory'},
        \ ]
    elseif l:ns ==# 'terraform'
      let l:candidates = [
        \ {'word': 'workspace', 'kind': 'v', 'menu': 'active workspace name'},
        \ {'word': 'applying',  'kind': 'v', 'menu': 'true during apply'},
        \ ]
    elseif has_key(l:proj.resources, l:ns)
      for l:rname in sort(keys(l:proj.resources[l:ns]))
        call add(l:candidates, {'word': l:rname, 'kind': 'r', 'menu': l:ns})
      endfor
    endif
  else
    " Top-level line (only leading whitespace before word) vs inside blocks/expressions
    if l:before =~# '^\s*$' && indent('.') == 0
      call extend(l:candidates, s:top_blocks)
    else
      call extend(l:candidates, s:top_blocks)
      call extend(l:candidates, s:keywords_and_types)
      for l:fn in s:functions
        call add(l:candidates, {'word': l:fn, 'kind': 'f', 'menu': 'func()'})
      endfor
      for l:rtype in sort(keys(l:proj.resources))
        call add(l:candidates, {'word': l:rtype, 'kind': 'r', 'menu': 'resource type'})
      endfor
    endif
  endif

  if empty(a:base)
    return l:candidates
  endif
  return filter(copy(l:candidates), 'stridx(v:val.word, a:base) == 0')
endfunction
