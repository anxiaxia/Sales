/**
 +-------------------------------------------------------------------
 * jQuery ThinkBox - 弹出层插件 - http://zjzit.cn/thinkbox
 +-------------------------------------------------------------------
 * @version    1.0.0beta
 * @since      2012.09.25
 * @author     麦当苗儿 <zuojiazi.cn@gmail.com>
 * @github     https://www.erdangjiade.com
 +-------------------------------------------------------------------
 */
(function(a) {
    function k() {
        this.css({zIndex: c++})
    }
    function l() {
        return a.extend({width: i.width(), height: i.height()}, {left: i.scrollLeft(), top: i.scrollTop()})
    }
    function m(b) {
        a.isFunction(b) && b.call(this)
    }
    function n(b, c) {
        a.each(b, function() {
            if (this in c)
                delete c[this]
        })
    }
    var b = {title: null, fixed: true, center: true, clone: true, x: 0, y: 0, modal: true, modalClose: true, resize: true, unload: false, close: "[关闭]", escHide: true, delayClose: 0, drag: false, display: true, width: "", height: "", dataEle: "", locate: ["left", "top"], show: ["fadeIn", "normal"], hide: ["fadeOut", "normal"], button: [], style: "default", titleChange: undefined, beforeShow: undefined, afterShow: undefined, afterHide: undefined, beforeUnload: undefined, afterDrag: undefined};
    var c = 2012;
    var d = null;
    var e = ['<div class="ThinkBox-wrapper" style="position:absolute;width: auto">', '<table cellspacing="0" cellpadding="0" border="0" style="width: auto">', "<tr>", '<td class="box-top-left"></td>', '<td class="box-top"></td>', '<td class="box-top-right"></td>', "</tr>", "<tr>", '<td class="box-left"></td>', '<td class="ThinkBox-inner"></td>', '<td class="box-right"></td>', "</tr>", "<tr>", '<td class="box-bottom-left"></td>', '<td class="box-bottom"></td>', '<td class="box-bottom-right"></td>', "</tr>", "</table>", "</div>"].join("");
    var f = ['<tr class="ThinkBox-title">', '<td class="box-title-left"></td>', '<td class="ThinkBox-title-inner"></td>', '<td class="box-title-right"></td>', "</tr>"].join("");
    var g = ['<tr class="ThinkBox-tools">', '<td class="box-tools-left"></td>', '<td class="ThinkBox-tools-inner"></td>', '<td class="box-tools-right"></td>', "</tr>"].join("");
    var h = a(document), i = a(window);
    var j = function(j, n) {
        function t() {
            function b() {
                n.delayClose && a.isNumeric(n.delayClose) && setTimeout(u, n.delayClose);
                m.call(o, n.afterShow)
            }
            if (p)
                return o;
            n.modal && z();
            m.call(o, n.beforeShow);
            switch (n.show[0]) {
                case"slideDown":
                    r.stop(true, true).slideDown(n.show[1], b);
                    break;
                case"fadeIn":
                    r.stop(true, true).fadeIn(n.show[1], b);
                    break;
                default:
                    r.show(n.show[1], b)
            }
            p = true;
            H();
            return o
        }
        function u() {
            function b() {
                p = false;
                m.call(o, n.afterHide);
                n.unload && G()
            }
            if (!p)
                return o;
            q && q.fadeOut("normal", function() {
                a(this).remove();
                q = null
            });
            switch (n.hide[0]) {
                case"slideUp":
                    r.stop(true, true).slideUp(n.hide[1], b);
                    break;
                case"fadeOut":
                    r.stop(true, true).fadeOut(n.hide[1], b);
                    break;
                default:
                    r.hide(n.hide[1], b)
            }
            return o
        }
        function v() {
            var b = a(f);
            var c = a(".ThinkBox-title-inner", b);
            if (n.drag) {
                c.addClass("ThinkBox-draging");
                c[0].onselectstart = function() {
                    return false
                };
                c[0].unselectable = "on";
                c[0].style.MozUserSelect = "none";
                C(c)
            }
            a("tr", r).first().after(b);
            w(n.title)
        }
        function w(b) {
            var c = a(".ThinkBox-title-inner", r).empty();
            if (a.isArray(b) || a.isPlainObject(b)) {
                a.each(b, function(b, d) {
                    a("<span>" + d + "</span>").data("key", b).click(function(b) {
                        var d = a(this);
                        if (!d.hasClass("selected")) {
                            c.find("span.selected").removeClass("selected");
                            d.addClass("selected");
                            m.call(d, n.titleChange)
                        }
                    }).mousedown(function(a) {
                        a.stopPropagation()
                    }).mouseup(function(a) {
                        a.stopPropagation()
                    }).appendTo(c)
                })
            } else {
                c.append("<span>" + b + "</span>")
            }
        }
        function x() {
            var b = a(g);
            var c = a(".ThinkBox-tools-inner", b);
            var d = null;
            a.each(n.button, function(b, e) {
                d = a("<span/>").addClass("ThinkBox-button " + e[0]).html(e[1]).click(function() {
                    m.call(o, e[2])
                }).hover(function() {
                    a(this).addClass("hover")
                }, function() {
                    a(this).removeClass("hover")
                }).appendTo(c)
            });
            a("tr", r).last().before(b)
        }
        function y() {
            a("<span/>").addClass("ThinkBox-close").html(n.close).click(function(a) {
                o.hide();
                a.stopPropagation()
            }).mousedown(function(a) {
                a.stopPropagation()
            }).appendTo(a(".ThinkBox-inner", r))
        }
        function z() {
            if (a.browser.msie) {
                h.width = function() {
                    return document.documentElement.scrollWidth
                };
                h.height = function() {
                    return document.documentElement.scrollHeight
                }
            }
            q = a('<div class="ThinkBox-modal-blackout" style="position:absolute;left:0;top:0"></div>').addClass("ThinkBox-modal-blackout-" + n.style).css({zIndex: c++, width: h.width(), height: h.height()}).click(function(a) {
                n.modalClose && d && d.hide();
                a.stopPropagation()
            }).mousedown(function(a) {
                a.stopPropagation()
            }).appendTo(a("body"));
            i.resize(function() {
                q && q.css({width: "", height: ""}).css({width: h.width(), height: h.height()})
            })
        }
        function A(b) {
            var b = a("<div/>").addClass("ThinkBox-content").append((n.clone ? a(b).clone(true, true) : a(b)).show());
            a(".ThinkBox-content", r).remove();
            a(".ThinkBox-inner", r).css({width: n.width, height: n.height}).append(b)
        }
        function B() {
            n.center ? D() : E(a.isNumeric(n.x) ? n.x : a.isFunction(n.x) ? n.x.call(a(n.dataEle)) : 0, a.isNumeric(n.y) ? n.y : a.isFunction(n.y) ? n.y.call(a(n.dataEle)) : 0)
        }
        function C(a) {
            var b = null;
            h.mousemove(function(a) {
                b && r.css({left: a.pageX - b[0], top: a.pageY - b[1]})
            });
            a.mousedown(function(a) {
                var c = r.offset();
                if (n.fixed) {
                    c.left -= i.scrollLeft();
                    c.top -= i.scrollTop()
                }
                b = [a.pageX - c.left, a.pageY - c.top]
            }).mouseup(function() {
                b = null;
                m.call(o, n.afterDrag)
            })
        }
        function D() {
            var a = F(), b = l(), c = r.css("position") == "fixed" ? [0, 0] : [b.left, b.top], d = c[0] + b.width / 2, e = c[1] + b.height / 2;
            E(d - a[0] / 2, e - a[1] / 2)
        }
        function E(b, c) {
            a.isNumeric(b) && (n.locate[0] == "left" ? r.css({left: b}) : r.css({right: b}));
            a.isNumeric(c) && (n.locate[1] == "top" ? r.css({top: c}) : r.css({bottom: c}))
        }
        function F() {
            if (p)
                return[r.width(), r.height()];
            else {
                r.css({visibility: "hidden", display: "block"});
                var a = [r.width(), r.height()];
                r.css("display", "none").css("visibility", "visible");
                return a
            }
        }
        function G() {
            m.call(o, n.beforeUnload);
            r.remove();
            n.dataEle && a(n.dataEle).removeData("ThinkBox")
        }
        function H() {
            d = o;
            k.call(r)
        }
        var o = this, p = false, q = null;
        var n = a.extend({}, b, n || {});
        var r = a(e).addClass("ThinkBox-" + n.style).data("ThinkBox", this);
        n.dataEle && a(n.dataEle).data("ThinkBox", this);
        r.hover(function() {
            m.call(o, n.mouseover)
        }, function() {
            m.call(o, n.mouseout)
        }).mousedown(function(a) {
            H();
            a.stopPropagation()
        }).click(function(a) {
            a.stopPropagation()
        });
        A(j || "<div></div>");
        n.title !== null && v();
        n.button.length && x();
        n.close && y();
        r.css("display", "none").appendTo("body");
        var s = r.find(".box-left");
        s.append(a("<div/>").css("width", s.width()));
        this.hide = u;
        this.show = t;
        this.toggle = function() {
            p ? o.hide() : o.show()
        };
        this.getContent = function() {
            return a(".ThinkBox-content", r)
        };
        this.setContent = function(a) {
            A(a);
            B();
            return o
        };
        this.setTitle = w;
        this.getSize = F;
        this.setSize = function(b, c) {
            a(".ThinkBox-inner", r).css({width: b, height: c})
        };
        n.fixed && (a.browser.msie && a.browser.version < 7 ? n.fixed = false : r.css("position", "fixed"));
        B();
        n.resize && i.resize(function() {
            B()
        });
        o.escHide = n.escHide;
        n.display && t();
    };
    h.mousedown(function() {
        d = null
    }).keypress(function(a) {
        d && d.escHide && a.keyCode == 27 && d.hide()
    });
    a.ThinkBox = function(b, c) {
        if (a.isPlainObject(c) && c.dataEle) {
            var d = a(c.dataEle).data("ThinkBox");
            if (d)
                return c.display === false ? d : d.show()
        }
        return new j(b, c)
    };
    a.extend(a.ThinkBox, {load: function(b, c) {
            var d = {clone: false, loading: "加载中...", type: "GET", dataType: "text", cache: false, parseData: undefined, onload: undefined}, e;
            a.extend(d, c || {});
            var f = d.parseData, g = d.onload, h = d.loading, b = b.split(/\s+/);
            var i = {data: d.data, type: d.type, dataType: d.dataType, cache: d.cache, success: function(c) {
                    b[1] && (c = a(c).find(b[1]));
                    a.isFunction(f) && (c = f.call(d.dataEle, c));
                    e.setContent(c);
                    m.call(e, g);
                    h || e.show()
                }};
            n(["data", "type", "cache", "dataType", "parseData", "onload", "loading"], d);
            e = h ? a.ThinkBox('<div class="ThinkBox-load-loading">' + h + "</div>", d) : a.ThinkBox("<div/>", a.extend({}, d, {display: false}));
            a.ajax(b[0], i);
            return e
        }, iframe: function(b, c) {
            var d = {width: 500, height: 400, scrolling: "no", onload: undefined}, e;
            a.extend(d, c || {});
            var f = d.onload;
            var g = a("<iframe/>").attr({width: d.width, height: d.height, frameborder: 0, scrolling: d.scrolling, src: b}).load(function() {
                m.call(e, f)
            });
            n(["width", "height", "scrolling", "onload"], d);
            e = a.ThinkBox(g, d);
            return e
        }, tips: function(b, c, d) {
            switch (c) {
                case 0:
                    c = "error";
                    break;
                case 1:
                    c = "success";
                    break
            }
            var e = '<div class="ThinkBox-tips ThinkBox-' + c + '">' + b + "</div>";
            var f = {modalClose: false, escHide: false, unload: true, close: false, delayClose: 1e3};
            a.extend(f, d || {});
            return a.ThinkBox(e, f)
        }, success: function(a, b) {
            return this.tips(a, "success", b)
        }, error: function(a, b) {
            return this.tips(a, "error", b)
        }, loading: function(a, b) {
            var c = b || {};
            c.delayClose = 0;
            return this.tips(a, "loading", c)
        }, msg: function(b, c) {
            var d = {drag: false, escHide: false, delayClose: 0, center: false, title: "消息", x: 0, y: 0, locate: ["right", "bottom"], show: ["slideDown", "slow"], hide: ["slideUp", "slow"]};
            a.extend(d, c || {});
            var e = a("<div/>").addClass("ThinkBox-msg").html(b);
            return a.ThinkBox(e, d)
        }, alert: function(b, c) {
            var d = {title: "提示", modal: false, modalClose: false, unload: false}, e = ["ok", "确定", undefined];
            a.extend(d, c || {});
            typeof d.okVal != "undefined" && (e[1] = d.okVal);
            a.isFunction(d.ok) && (e[2] = d.ok);
            n(["okVal", "ok"], d);
            d.button = [e];
            var f = a("<div/>").addClass("ThinkBox-alert").html(b);
            return a.ThinkBox(f, d)
        }, confirm: function(b, c) {
            var d = {title: "确认", modal: false, modalClose: false}, e = [["ok", "确定", undefined], ["cancel", "取消", undefined]];
            a.extend(d, c || {});
            typeof d.okVal != "undefined" && (e[0][1] = d.okVal);
            typeof d.cancelVal != "undefined" && (e[1][1] = d.cancelVal);
            a.isFunction(d.ok) && (e[0][2] = d.ok);
            a.isFunction(d.cancel) && (e[1][2] = d.cancel);
            n(["okVal", "ok", "cancelVal", "cancel"], d);
            d.button = e;
            var f = a("<div/>").addClass("ThinkBox-confirm").html(b);
            return a.ThinkBox(f, d)
        }, get: function(b) {
            return a(b).closest(".ThinkBox-wrapper").data("ThinkBox")
        }});
    a.fn.ThinkBox = function(b) {
        function c(b) {
            var c = this.attr("think-href") || this.attr("href");
            if (c.substr(0, 1) == "#") {
                a.ThinkBox(c, b)
            } else if (c.substr(0, 7) == "http://" || c.substr(0, 8) == "https://") {
                a.ThinkBox.iframe(c, b)
            } else {
                a.ThinkBox.load(c, b)
            }
        }
        if (b == "get")
            return a(this).data("ThinkBox");
        return this.each(function() {
            var d = a(this);
            var e = d.data("ThinkBox");
            switch (b) {
                case"show":
                    e && e.show();
                    break;
                case"hide":
                    e && e.hide();
                    break;
                case"toggle":
                    e && e.toggle();
                    break;
                default:
                    var f = {title: d.attr("title"), dataEle: this, fixed: false, center: false, modal: false, drag: false};
                    b = a.isPlainObject(b) ? b : {};
                    a.extend(f, {x: function() {
                            return a(this).offset().left
                        }, y: function() {
                            return a(this).offset().top + a(this).outerHeight()
                        }}, b);
                    if (f.event) {
                        var g = f.event;
                        delete f.event;
                        if (g == "hover") {
                            var h = f.boxOutClose || false, i = f.delayShow || 0, j = null, k = null;
                            n(["boxOutClose", "delayShow"], f);
                            f.mouseover = function() {
                                if (k) {
                                    clearTimeout(k);
                                    k = null
                                }
                            };
                            f.mouseout = function() {
                                this.hide()
                            };
                            d.hover(function() {
                                j = j || setTimeout(function() {
                                    c.call(d, f)
                                }, i)
                            }, function() {
                                if (j) {
                                    clearTimeout(j);
                                    j = null
                                }
                                h ? k = k || setTimeout(function() {
                                    k = null;
                                    d.ThinkBox("hide")
                                }, 50) : d.ThinkBox("hide")
                            })
                        } else {
                            d.bind(g, function() {
                                c.call(d, f);
                                return false
                            })
                        }
                    } else {
                        c.call(d, f)
                    }
            }
        })
    }
})(jQuery)