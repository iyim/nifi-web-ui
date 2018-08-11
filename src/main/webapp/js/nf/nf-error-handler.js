/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* global define, module, require, exports */

(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define(['jquery',
                'nf.Dialog',
                'nf.Common'],
            function ($, nfDialog, nfCommon) {
                return (nf.ErrorHandler = factory($, nfDialog, nfCommon));
            });
    } else if (typeof exports === 'object' && typeof module === 'object') {
        module.exports = (nf.ErrorHandler = factory(require('jquery'),
            require('nf.Dialog'),
            require('nf.Common')));
    } else {
        nf.ErrorHandler = factory(root.$,
            root.nf.Dialog,
            root.nf.Common);
    }
}(this, function ($, nfDialog, nfCommon) {
    'use strict';

    return {
        /**
         * Method for handling ajax errors.
         *
         * @argument {object} xhr       The XmlHttpRequest
         * @argument {string} status    The status of the request
         * @argument {string} error     The error
         */
        handleAjaxError: function (xhr, status, error) {
            if (status === 'canceled') {
                if ($('#splash').is(':visible')) {
                    $('#message-title').text('会话已过期');
                    $('#message-content').text('您的会话已过期。请重新加载以重新登录.');

                    // show the error pane
                    $('#message-pane').show();
                } else {
                    nfDialog.showOkDialog({
                        headerText: '会话过期',
                        dialogContent: '您的会话已过期。请按确定再次登录.',
                        okHandler: function () {
                            window.location = '/nifi';
                        }
                    });
                }
                return;
            }

            // if an error occurs while the splash screen is visible close the canvas show the error message
            if ($('#splash').is(':visible')) {
                if (xhr.status === 401) {
                    $('#message-title').text('未授权');
                } else if (xhr.status === 403) {
                    $('#message-title').text('权限不足');
                } else if (xhr.status === 409) {
                    $('#message-title').text('无效状态');
                } else {
                    $('#message-title').text('发生意外的错误');
                }

                if ($.trim(xhr.responseText) === '') {
                    $('#message-content').text('请检查日志.');
                } else {
                    $('#message-content').text(xhr.responseText);
                }

                // show the error pane
                $('#message-pane').show();
                return;
            }

            // status code 400, 404, and 409 are expected response codes for nfCommon errors.
            if (xhr.status === 400 || xhr.status === 404 || xhr.status === 409 || xhr.status === 503) {
                nfDialog.showOkDialog({
                    headerText: 'Error',
                    dialogContent: nfCommon.escapeHtml(xhr.responseText)
                });
            } else if (xhr.status === 403) {
                nfDialog.showOkDialog({
                    headerText: '权限不足',
                    dialogContent: nfCommon.escapeHtml(xhr.responseText)
                });
            } else {
                if (xhr.status < 99 || xhr.status === 12007 || xhr.status === 12029) {
                    var content = '请确保应用程序正在运行，并检查日志中是否有任何错误.';
                    if (nfCommon.isDefinedAndNotNull(status)) {
                        if (status === 'timeout') {
                            content = '请求已超时。请确保应用程序正在运行，并检查日志中是否有任何错误.';
                        } else if (status === 'abort') {
                            content = '请求已中止.';
                        } else if (status === 'No Transport') {
                            content = '请求传输机制失败。请确保可以访问运行应用程序的主机.';
                        }
                    }
                    $('#message-title').text('无法与NiFi通信');
                    $('#message-content').text(content);
                } else if (xhr.status === 401) {
                    $('#message-title').text('未授权');
                    if ($.trim(xhr.responseText) === '') {
                        $('#message-content').text('使用此NiFi需要身份验证.');
                    } else {
                        $('#message-content').text(xhr.responseText);
                    }
                } else if (xhr.status === 500) {
                    $('#message-title').text('发生意外的错误');
                    if ($.trim(xhr.responseText) === '') {
                        $('#message-content').text('与应用程序核心通信时发生错误。请在重新启动之前检查日志并修复任何配置问题.');
                    } else {
                        $('#message-content').text(xhr.responseText);
                    }
                } else if (xhr.status === 200 || xhr.status === 201) {
                    $('#message-title').text('解析错误');
                    if ($.trim(xhr.responseText) === '') {
                        $('#message-content').text('无法解释来自NiFi的回应.');
                    } else {
                        $('#message-content').text(xhr.responseText);
                    }
                } else {
                    $('#message-title').text(xhr.status + ': 意外的响应');
                    $('#message-content').text('发生意外的错误。请检查日志.');
                }

                // show the error pane
                $('#message-pane').show();
            }
        }
    };
}));