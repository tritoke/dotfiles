call Iab('main', 'fn main() {<Enter>}<Esc>O')
call Iab('wlnd', 'writeln!(x, "{:?}", <++>)?;<Esc>Fxs')
call Iab('wln', 'writeln!(x, "{}", <++>)?;<Esc>Fxs')
call Iab('plnd', 'println!("{:?}", x);<Esc>Fxs')
call Iab('pln', 'println!("{}", x);<Esc>Fxs')
call Iab('eplnd', 'eprintln!("{:?}", x);<Esc>Fxs')
call Iab('epln', 'eprintln!("{}", x);<Esc>Fxs')
call Iab('#d', '#[derive(x)]<Esc>Fxs')
call Iab('#f', '#![feature(x)]<Esc>Fxs')
call Iab('#r', '#[repr(x)]<Esc>Fxs')
