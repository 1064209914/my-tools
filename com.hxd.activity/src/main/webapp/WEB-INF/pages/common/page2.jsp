<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-sm-6">
	<div class="dataTables_info" id="sample-table-2_info">
		<%-- 显示${(page.pageNo-1) * page.pageSize +1}条到${(page.pageNo * page.pageSize) > page.totalCount ? page.totalCount : page.pageNo * page.pageSize}条记录，共${page.totalCount }条 --%>
		<c:if test="${page.totalCount >0 }"> 共${page.totalCount }条，第${page.pageNo }页  </c:if>
	</div>
</div>
<div class="col-sm-5">
	<div class="dataTables_paginate paging_bootstrap">
		<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
						
									<ul class="pagination">
										<c:if test="${page.pageNo <= 1 }">
											<li class="prev disabled"><a href="#"
												onclick=""> <i
													class="icon-double-angle-left">首页 </i>
											</a></li>
										</c:if>
										<c:if test="${page.pageNo > 1 }">
											<li class="prev"><a href="#"
												onclick="movePage(1);"> <i
													class="icon-double-angle-left">首页 </i>
											</a></li>
										</c:if>	
									  <c:if test="${page.pageNo <= 1 }">
											<li class="prev disabled"><a href="#"
												onclick=""> <i
													class="icon-double-angle-left">上一页 </i>
											</a></li>
										</c:if>
										<c:if test="${page.pageNo > 1 }">
											<li class="prev"><a href="#"
												onclick="movePage('${page.pageNo-1}');"> <i
													class="icon-double-angle-left">上一页 </i>
											</a></li>
										</c:if>																					
										<c:if test="${page.pageNo+1 <= page.totalPageCount }">
											<li class="next "><a href="#"
												onclick="movePage('${page.pageNo+1}');"> <i
													class="icon-double-angle-right">下一页</i></a></li>
										</c:if>
										<c:if test="${page.pageNo+1 > page.totalPageCount }">
											<li class="next disabled"><a href="#"
												onclick=""> <i
													class="icon-double-angle-right">下一页</i></a></li>
										</c:if>										
										<c:if test="${page.pageNo+1 <= page.totalPageCount }">
											<li class="next "><a href="#"
												onclick="movePage('${page.totalPages }');"> <i
													class="icon-double-angle-right">尾页</i></a></li>
										</c:if>
										<c:if test="${page.pageNo+1 > page.totalPageCount }">
											<li class="next disabled"><a href="#"
												onclick=""> <i
													class="icon-double-angle-right">尾页</i></a></li>
										</c:if>																	
									</ul>		
	</div>
</div>
<script type="text/javascript">
function movePage(pageNo){
	var url = $("#queryForm").attr("action");
	var param = $("#queryForm").serialize();
	param += "&pageNo=" + pageNo;
	param += "&qry_type=qry";	
	param += "&orgId="+$("#org_pid").val();
	$.post(url, param, function(result) {	
		$("#qryContent").html(result);
		setHash('${pageContext.request.contextPath}');
	});	
};	
</script>