<#include "include/macros.ftl">
<@header></@header>
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="login_wrapper">
                    <div class="animate form login_form" style="position: relative;">
                        <section class="login_content">
                            <form action="/passport/signin" method="POST" id="login-form">
                                <h1>登录管理系统</h1>
                                <#if message?exists>
                                    <div class="alert alert-danger" role="alert">
                                        ${message?if_exists}
                                    </div>
                                </#if>
                                <div>
                                    <input type="text" class="form-control" placeholder="请输入用户名" name="username" required=""/>
                                </div>
                                <div>
                                    <input type="password" class="form-control" placeholder="请输入密码" name="password" required=""/>
                                </div>
                                <#if enableKaptcha?exists && enableKaptcha>
                                    <div class="form-group col-xs-6" style="padding-left: 0px;">
                                        <img alt="点击获取验证码" id="img-kaptcha" src="/getKaptcha" style="cursor:pointer;height: 34px;width: 180px;">
                                    </div>
                                    <div class="form-group col-xs-6">
                                        <span><input type="text" class="form-control" placeholder="验证码" id="kaptcha" name="kaptcha"></span>
                                    </div>
                                </#if>
                                <div class="form-group" style="text-align : left">
                                    <label><input type="checkbox" id="rememberMe" name="rememberMe" style="width: 12px; height: 12px;margin-right: 5px;"> 记住我</label>
                                </div>
                                <div>
                                    <button type="button" class="btn btn-success btn-login" style="width: 100%;">登录</button>
                                </div>
                                <div class="login-loading hide">
                                    <i class="fa fa-spinner fa-pulse"></i>正在登录中...
                                </div>

                                <div class="clearfix"></div>

                                <div class="separator">
                                    <div class="clearfix"></div>
                                    <div>
                                        <h1><i class="fa fa-coffee"></i> ${config.siteName}管理系统</h1>
                                        <p>Copyright © 2018 <a href="https://www.zhyd.me" target="_blank" style="margin: 0">yadong.zhang</a>. All Rights Reserved. </p>
                                    </div>
                                </div>
                            </form>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<@footer>
    <script>
        $("#modal").modal('show');
        $(".btn-login").click(function () {
            $(".login-loading").removeClass("hide");
            $.ajax({
                type: "POST",
                url: "/passport/signin",
                data: $("#login-form").serialize(),
                dataType: "json",
                success: function (json) {
                    $(".login-loading").addClass("hide");
                    if (json.status == 200) {
                        window.location.href = "/";
                    }else{
                        $.alert.error(json.message);
                        $("#img-kaptcha").attr("src", '/getKaptcha?time=' + new Date().getTime());
                    }
                }
            });
        });
        $("#img-kaptcha").click(function () {
            $(this).attr("src", '/getKaptcha?time=' + new Date().getTime());
        });
        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
                $(".btn-login").click();
            }
        };
    </script>
</@footer>
