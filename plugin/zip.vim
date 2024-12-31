let g:zip_default_size = get(g:, 'zip_default_size', 2)

function! s:zip(from, to, size = 0) abort
  let size = a:size == 0 ? g:zip_default_size : a:size
  let lines = getline(a:from, a:to)
  let n = len(lines)
  if n % size != 0
    echomsg printf('Invalid size: line count %d is not a multiple of %d', n, size)
    return
  endif
  let n = n / size
  let result = []
  for i in range(n)
    for j in range(size)
      let result += [lines[i + j * n]]
    endfor
  endfor
  call setline(a:from, result)
endfunction

function! s:unzip(from, to, size = 0) abort
  let size = a:size == 0 ? g:zip_default_size : a:size
  let lines = getline(a:from, a:to)
  let n = len(lines)
  if n % size != 0
    echomsg printf('Invalid size: line count %d is not a multiple of %d', n, size)
    return
  endif
  let n = n / size
  let result = []
  for j in range(size)
    for i in range(n)
      let result += [lines[i * size + j]]
    endfor
  endfor
  call setline(a:from, result)
endfunction

command! -nargs=? -range Zip call <SID>zip(<line1>, <line2>, <args>)
command! -nargs=? -range Unzip call <SID>unzip(<line1>, <line2>, <args>)
