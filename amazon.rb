#codning:utf-8
require "rubygems"
require "mechanize"


azn_user_name = "takuya@eample.com"
azn_user_pass = "my_password"

m = Mechanize.new
m.user_agent_alias = 'Mac Safari'
m.get 'https://www.amazon.co.jp/ap/signin?_encoding=UTF8&openid.assoc_handle=jpflex&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0'
m.page.forms[1].field_with(:name=>/email/).value = azn_user_name
m.page.forms[1].field_with(:name=>/pass/).value = azn_user_pass
m.page.forms[1].submit()


ret = []
m.get "http://www.amazon.co.jp/gp/cart/view.html"
puts m.page.body

(1..25).map{|i| "http://www.amazon.co.jp/gp/cart/view.html/ref=ox_page_sfl_2?ie=UTF8&dc=df&page=#{i}&type=saved" }
.each{|e| 
		m.get(e);
		m.page.search("#cart-saved-items div.item-list .product-title a[href^='http']").map{|e| ret.push [e.text,e["href"]]
	}
}

# puts m.page.body.toutf8
# puts m.page.search("#cart-saved-items div.item-list .product-title a[href^='http']").map{|e|  e.text}
# puts ret
# puts ret.inspect
puts ret.map{|e| "%-105s -- %s" % [ e[1], e[0]] }.join("\n")
