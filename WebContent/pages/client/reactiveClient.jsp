<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

			<form class="form-horizontal" id="activeClient" name="activeClient">
				<fieldset>
						<legend><spring:message code="lable.reactive.client"/></legend>
	
					<div class="form-group">
						<label for="activationDate" class="col-sm-2 control-label"><spring:message code="lable.active.date"/><span
							style="font-size: 14px; color: #d9534f">*</span>
						</label>
						<div class="col-sm-3">
							<input type="text" datetype="date" name="reactiveDate" local-date="true">
						</div>
					</div>
	
			<div class="form-group">
						<div class="text-right" style="padding-right: 80px">
							<button type="button" id="save" name="save" class="btn btn-primary" ><spring:message code="btn.submit"/></button>
						</div>
					</div>
				</fieldset>
			</form>

	<script type="text/javascript">
		$(document).ready(function() {
				$.valid("activeClient", [ {
					"name" : "activationDate",
					"notEmpty" : "不能为空"
				}]);
				$.datetimepicker();
				
				$.getWidget("save").click(function() {
				var json = {
							  "locale": "en",
							  "dateFormat": $('input[name="reactiveDate"]').attr('date-format'),
							  "reactivationDate": $.value('reactiveDate')
							}
				
				$.nest({
					url : "<c:url value='/fineract.do'/>",
					type : "post",
					async : true,
					data : {
						"dataType" : "POST",
						"mydata" : json,
						"url" : "api.v1.clients."+clientId+"?command=reactivate"
					},
					callback : "callback"
				});
			});
		});
		function callback(param) {
			$.setReadOnly("activeClient");
			$.bAlert($.fn.bootstrapValidator.i18n.common.tipSaveSuccessful);
			var clientId;
			if(param != null || param.length > 0 || typeof param != 'undefined'){
				clientId = param.clientId;
				window.location.href="loadPage.do?nextPage=client.detail&clientId="+clientId;
			}
		}
</script>