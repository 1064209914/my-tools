<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
			<ol  id= "notices" class="dropdown-navbar" style="position: fixed;top: 39px;
			left: 100%;margin-left: -390px;width: 170px;list-style: none; overflow: auto;background:#fff;
			max-height: 140px;">
				<c:forEach items="${noticeList}" var="notice" varStatus="i">
						<li style="float: none;<c:if test='${notice == null}'>display: none;</c:if>" class="notice">
							<a onclick="getNotice($(this))"  style="display:block;padding:6px 2px;margin:0;font-size:12px;border-bottom :1px solid;border-bottom-color:#e4ecf3;" >
								<div class="clearfix">
									<span class="pull-left">
										<i class="btn btn-xs no-hover btn-pink icon-envelope-alt" style="height: 22px;border-radius: 3px;padding-top: 2px;"></i>
											<i style="color: black;font-style: normal;width:75px;display: inline-block;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" class="noticeTitle2">${notice.title}</i>
											<span><fmt:formatDate value="${notice.publish_time}" pattern="MM-dd"/></span>
											<input type="hidden" value="${notice.id}" class="noticeId"/>
											<input type="hidden" value="${notice.title}" class="noticeTitle"/>
									</span>
									<span class="pull-right badge badge-info"></span>
								</div>
							</a>
						</li>
				 </c:forEach> 
				<li style="float: none;padding: 0px;height: 30px;<c:if test='${noticeList.get(4) == null}'>display: none;</c:if>" class="otherNotice" >
						<a href="#" onclick="goNotices();" >
							更多...
						<i class="icon-arrow-right"></i>
						</a>
					</li>
			</ol>
</html>

