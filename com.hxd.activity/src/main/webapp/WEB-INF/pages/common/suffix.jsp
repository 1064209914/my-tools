<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
		<div id="iframeDiv" style="display:none"></div>
		<div class="page-content" id="loadPageContent">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form class="form-horizontal" id="sub_forms" method="post">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="macId">MAC地址：</label>
						<div class="col-sm-8 no-padding">
							<input type="text" id="macIps" class="col-xs-10 col-sm-5" name="macIps" value="${macIp}" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="skill_code">分机号：</label>
						<div class="col-sm-8 no-padding">
							<input type="text" id="suffix" name="suffix" placeholder="请输入分机号" class="yellow-bg col-xs-10 col-sm-5" />
						</div>
					</div>
				</form>
			</div>
		</div>
		</div>
</html>

