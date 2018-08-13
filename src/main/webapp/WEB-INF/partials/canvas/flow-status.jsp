<%--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" session="false" %>
<div id="flow-status" flex layout="row" layout-align="space-between center">
    <div id="flow-status-container" layout="row" layout-align="space-around center">
        <div class="fa fa-cubes" ng-if="appCtrl.nf.ClusterSummary.isClustered()" ng-class="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.getExtraClusterStyles()"
             title="Connected nodes / Total number of nodes in the cluster">
            <span id="connected-nodes-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.connectedNodesCount}}</span>
        </div>
        <div class="icon icon-threads" ng-class="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.getExtraThreadStyles()"
             title="活动线程数{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.hasTerminatedThreads() ? ' (Terminated)' : ''}}">
            <span id="active-thread-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.threadCounts}}</span>
        </div>
        <div class="fa fa-list" title="总排队数据">
            <span id="total-queued">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.totalQueued}}</span>
        </div>
        <div class="fa fa-bullseye" title="传输远程流程组">
            <span id="controller-transmitting-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerTransmittingCount}}</span>
        </div>
        <div class="icon icon-transmit-false" title="不传输远程流程组">
            <span id="controller-not-transmitting-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerNotTransmittingCount}}</span>
        </div>
        <div class="fa fa-play" title="运行组件">
            <span id="controller-running-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerRunningCount}}</span>
        </div>
        <div class="fa fa-stop" title="停止运行组件">
            <span id="controller-stopped-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerStoppedCount}}</span>
        </div>
        <div class="fa fa-warning" title="无效组件">
            <span id="controller-invalid-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerInvalidCount}}</span>
        </div>
        <div class="icon icon-enable-false" title="禁用组件">
            <span id="controller-disabled-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerDisabledCount}}</span>
        </div>
        <div class="fa fa-check" title="最新的版本化流程组">
            <span id="controller-up-to-date-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerUpToDateCount}}</span>
        </div>
        <div class="fa fa-asterisk" title="Locally modified Versioned Process Groups">
            <span id="controller-locally-modified-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerLocallyModifiedCount}}</span>
        </div>
        <div class="fa fa-arrow-circle-up" title="Stale Versioned Process Groups">
            <span id="controller-stale-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerStaleCount}}</span>
        </div>
        <div class="fa fa-exclamation-circle" title="Locally modified and stale Versioned Process Groups">
            <span id="controller-locally-modified-and-stale-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerLocallyModifiedAndStaleCount}}</span>
        </div>
        <div class="fa fa-question" title="Sync failure Versioned Process Groups">
            <span id="controller-sync-failure-count">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.controllerSyncFailureCount}}</span>
        </div>
        <div class="fa fa-refresh" title="Last refresh">
            <span id="stats-last-refreshed">{{appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.statsLastRefreshed}}</span>
        </div>
        <div id="canvas-loading-container" class="loading-container"></div>
    </div>
    <div layout="row" layout-align="end center">
        <div id="search-container">
            <button id="search-button" ng-click="appCtrl.serviceProvider.headerCtrl.flowStatusCtrl.search.toggleSearchField();"><i class="fa fa-search"></i></button>
            <input id="search-field" type="text" placeholder="Search"/>
        </div>
        <button id="bulletin-button"><i class="fa fa-sticky-note-o"></i></button>
    </div>
</div>
<div id="search-flow-results"></div>
