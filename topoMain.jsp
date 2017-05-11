<%@ page language="java" contentType="text/html; charset=utf-8" import="java.util.*"%>

<!-- ,com.eastcom.portal.action.* -->

<html>
<head>
</head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>拓扑信息管理页面</title>
    <link rel="stylesheet" href="resources/css/base.css"/>
     <link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="resources/lib/bootstrap/css/bootstrap-treeview.css" rel="stylesheet"/>
    <script language="JavaScript" src="resources/lib/jquery.min.js"></script>
     <script src="resources/js/tetra_com.js" type="text/javascript"></script>
     
     <script language="JavaScript" src="resources/lib/bootstrap/js/bootstrap-treeview.js"></script>
    <script src="resources/js/user/user-com.js" type="text/javascript"></script>
    <link href="resources/css/style.css" rel="stylesheet" type="text/css" />
   
    <link rel="stylesheet" type="text/css" href="topo/js/ext3.0.0/resources/css/ext-all.css"/>
    <script type="text/javascript" src="topo/js/ext3.0.0/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="topo/js/ext3.0.0/ext-all.js"></script>
    <script type="text/javascript" src="topo/js/PagingMemoryProxy_3.js"></script>
    <script type="text/javascript" src="topo/js/AnyChart.js"></script>
    <script type="text/javascript" src="topo/js/ext3.0.0/resources/ext-lang-zh_CN.js"></script>
    <script src="topo/ui/js/ext2/dwrproxy.js"></script>
</head>

 <script type="text/javascript">
        $(function () {
        appendHtml('rs/sys/userLogin/findUserHavePermission/TOPU_MANAGE');
        
          });
            

    </script> 
    <%
//System.out.println("---aaa");
	List<String> titleList = null;//(List<String>)session.getAttribute("titleList");
	List<String> cityList = new ArrayList<String>();	//(List<String>)session.getAttribute("cityList");
	
	cityList.add("湖州");
    cityList.add("金华");
    cityList.add("嘉兴");
    cityList.add("丽水");
    cityList.add("宁波");
    cityList.add("衢州");
    cityList.add("绍兴");
    cityList.add("台州");
    cityList.add("温州");
    cityList.add("舟山");
    cityList.add("省公司");
    cityList.add("杭州");
	//List<String> titleList = null;
	//List<String> cityList = null;
	//System.out.println("---"+cityList);
	String userName=session.getAttribute("loginUser").toString();
	//System.out.println("cityList====="+cityList.size());
	//String isOpenTree = new String(request.getParameter("isOpen").getBytes("ISO8859-1"), "GBK");
	String isOpenTree = "true";
	//if (titleList == null) {
    //    response.sendRedirect("login.jsp");
    //    return;
	//}
	
	String cityStr = "";
	if(cityList != null){
		for(int i=0;i<cityList.size();i++){
			cityStr += cityList.get(i)+",";
		}
		if(cityStr != ""){
			cityStr = cityStr.substring(0,cityStr.length()-1);
		}
	}
	System.out.println("cityStr====="+cityStr);
	System.out.println("isOpenTree====="+isOpenTree);
%>
	<script type="text/javascript">
		var win;
		var cityStr = "<%=cityStr%>";
		var userName = "<%=userName%>";
		var flag = "<%=isOpenTree%>";
		if((cityStr.split(",")).length > 1){
			if((cityStr.split(",")).length == 2){//绍兴角色配置了两个地市(绍兴,省公司) 特殊处理
				if(cityStr.indexOf("杭州") != -1){
					cityStr = "杭州";
				}else if(cityStr.indexOf("湖州") != -1){
					cityStr = "湖州";
				}else if(cityStr.indexOf("嘉兴") != -1){
					cityStr = "嘉兴";
				}else if(cityStr.indexOf("金华") != -1){
					cityStr = "金华";
				}else if(cityStr.indexOf("丽水") != -1){
					cityStr = "丽水";
				}else if(cityStr.indexOf("宁波") != -1){
					cityStr = "宁波";
				}else if(cityStr.indexOf("绍兴") != -1){
					cityStr = "绍兴";
				}else if(cityStr.indexOf("台州") != -1){
					cityStr = "台州";
				}else if(cityStr.indexOf("温州") != -1){
					cityStr = "温州";
				}else if(cityStr.indexOf("舟山") != -1){
					cityStr = "舟山";
				}else if(cityStr.indexOf("衢州") != -1){
					cityStr = "衢州";
				}
			}else{
				cityStr = "省公司";
			}
		}
		
		Ext.onReady(function(){
			loadPage();
		});
	
		function loadPage(){
			var city= encodeURI(cityStr);
			document.getElementById("topoIframe").src = "jsp/topoFlex_ds/index.jsp?cityStr="+city+"&oper=show&topoName=&userName="+userName+"&isOpen="+flag;
		
		}
	
		function showDetailByType(type,id,name,deviceType,deviceVendor){
	   		//alert(type+";;;"+id+";;;"+name+";;;;"+deviceType+";;;;"+deviceVendor);
	   		var url = "";
	   		var urlResource="topu";
			var title="查看详情";
	   		if(type == "设备信息" && (deviceType=="BS")){//基站
				title=name +"-"+type;
	   			url = "topo/deviceTab/deviceTabs.jsp?deviceId="+id+"&verson="+deviceVendor+"&height=&width=";
	   		}
	   		else if(type == "设备信息" && deviceType!="BS"){
				title=name +"-"+type;
				console.log(deviceType);
				if(deviceType=="ROUTER"){
			     url="jsp/res/datanetwork/DeviceRouterDetail.jsp?id="+id+"&urlResource="+urlResource;
			     
				}
				if(deviceType=="SWTICH"||deviceType=="ISGW"){
				     url="jsp/res/datanetwork/DeviceSwitchDetail.jsp?id="+id+"&urlResource="+urlResource;
				     
				}
				if(deviceType=="MSC"){
				     url="jsp/res/tetra/DeviceImscDetail.jsp?id="+id+"&urlResource="+urlResource;
				     
				}
				if(deviceType=="HOST"){
				     url="jsp/res/hosthome/DeviceHostDetail.jsp?id="+id+"&urlResource="+urlResource;
				     
				}
				//url ="topo/tabDetail/devicePerformanceDetail.jsp?deviceId="+id+"&deviceType=device";
				
			}
	   		else if(type == "告警信息"){
				title=name +"-"+type;
				//console.log(title);
				url ="../tetra_fm/fm_manage.html?deviceId="+id+"&urlResource="+urlResource;
			}
	   		
	   		else if(type == "性能信息"){
				title=name +"-"+type;
				url = "topo/tabDetail/echartTopuDetail.html?device_id="+id+"&deviceType="+deviceType;
			}
	   		
	   		
	   		
	   		/*else if(type == "用户信息" && deviceType=="EBS"){
				title=name +"-"+type;
	   			url="userList_manager.jsp?BS_ID="+id;
	   		}else if(type == "警员调度" && deviceType=="EBS"){
				url = "talkList.jsp?BS_ID="+id;
				title=name +"-"+type;
			}
			
			
			else if(type == "设备信息" && deviceType=="IMSC"){//交换中心
				title=name +"-"+type;
				if(deviceVendor=="NEOLINK")
	   			    url= "topo/deviceTab/neoImscdeviceTab.jsp?deviceId="+id+"&height=&width=";//NEOLINK
	   			else
			       url = "topo/deviceTab/gUserTab.jsp?deviceId="+id+"&height=&width=";
	   		}*/else if(type == "无线用户" && deviceType=="MSC"){
	   		
				var sid2="userSid"+new Date();
			         var sid2="userSid"+new Date();
				     title=name +"-"+type;
			    if(deviceVendor=='NEOLINK')
					url = "topo/tableList/neoUserList.jsp?height=&width=";
			    else
			        url = "topo/tableList/userList.jsp?deviceId="+id+"&ids="+sid2
						+"&radioSubID=&name=&alias=&policeNumber=&PDTDialingRule=&radioType=&policeType=&radioSN=&virtualNetwork=&PDTDialing=&flag=true"
						+"&height=&width=";
			}/*else if(type == "性能信息" && deviceType=="IMSC"){
				title=name +"-"+type;
				url = "topo/tabDetail/devicePerformanceDetail.jsp?deviceId="+id+"&deviceType=device&height=&width=";
			}else if(type == "告警信息" && deviceType=="IMSC"){
				title=name +"-"+type;
				url = "topo/tabDetail/alarmDetail.jsp?deviceId="+id+"&height=&width=";
			}*/
			
			
			/*else if(type == "设备信息" && (deviceType=="ROUTER"||deviceType=="SWTICH")){//路由器和交换机
				title=name +"-"+type;
	   			url="topo/tabMain/dTab.jsp?deviceId="+id+"&height=&width=&deviceName=undefined&deviceType=device";
	   			
	   		}else if(type == "接口信息" && (deviceType=="ROUTER"||deviceType=="SWTICH")){
				title=name +"-"+type;
				console.log(title);
				url ="topo/tabDetail/interfaceDetail.jsp?deviceId="+id+"&flag=true"+"&height=&width=";
				
			}else if(type == "告警信息" && (deviceType=="ROUTER"||deviceType=="SWTICH")){
				title=name +"-"+type;
				url =  "topo/tabDetail/alarmDetail.jsp?deviceId="+id+"&height=&width=";
			}*/
			
			
			else if(type == "设备信息" && deviceType=="DS"){//调度台
				title=name +"-"+type;
				url="topo/deviceTab/dispatching_Desk.jsp?id="+id+"&linkName="+name+"&title="+title;
				
			}else if(type == "设备信息" && deviceType=="SMC"){//短信中心
				title=name +"-"+type;
				url="topo/deviceTab/sMS_center.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="PDC"){//分组中心
				title=name +"-"+type;
				url="topo/deviceTab/group_Center.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="RSRC"){//录音器
				title=name +"-"+type;
				url="topo/deviceTab/recorder.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="PBS"){//同播基站
				title=name +"-"+type;
				url="topo/deviceTab/simulcasting_Base_Station.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="PSS"){//同播服务器
				title=name +"-"+type;
				url="topo/deviceTab/simulcasting_Server.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="AUC"){//鉴权中心
				title=name +"-"+type;
				url="topo/deviceTab/authentication_Center.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="ISGW"){//综合业务网关
				title=name +"-"+type;
				url="topo/deviceTab/iMSG.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="SMG"){//短信业务网关
				title=name +"-"+type;
				url="topo/deviceTab/short_Message_Service.jsp?id="+id+"&linkName="+name+"&title="+title;
			}else if(type == "设备信息" && deviceType=="DSGW"){//模拟网关
				title=name +"-"+type;
				url="topo/deviceTab/cmpp_Service.jsp?id="+id+"&linkName="+name+"&title="+title;
			}
	   		console.log(url);
	   		var Window = new Ext.Window({
	   			title:title,
			    width:Ext.lib.Dom.getViewWidth()*0.8,
		        height:Ext.lib.Dom.getViewHeight()*0.8,
		        html:'<iframe marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" height="100%" width="100%" src="'+url+'">'
			})
			Window.show();
	   	}
	   	
	   	function showEditTopoWin(city,topoName){
	   		var url = "jsp/topoFlex_ds/index.jsp?cityStr="+city+"&oper=edit&topoName="+topoName+"&userName="+userName+"&isOpen="+flag
	   		var Window = new Ext.Window({
	   			title:"拓扑编辑",
			    width:Ext.lib.Dom.getViewWidth()-10,
		        height:Ext.lib.Dom.getViewHeight()-20,
		        html:'<iframe id="editTopoFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" height="100%" width="100%" src="'+url+'">'
			})
			Window.show();
	   	}
	   	
	   	function showAddOrEditLinkWin(fromId,toId,linkId){
	   		var title = "";
	   		if(linkId == ""){
	   			title = "新建电路";
	   		}else{
	   			title = "编辑电路";
	   		}
	   		//var url = "http://192.168.1.54:8080/ipnet/jsp/link/addLink.jsp?leftId="+fromId+"&rightId="+toId+"&linkId="+linkId;
	   		//var url = "link/addLink.jsp?leftId="+fromId+"&rightId="+toId+"&linkId="+linkId;
	   		
	   		var url = "topo/link/addLink.jsp?leftId="+fromId+"&rightId="+toId+"&linkId="+linkId;
	   		
	   		win = new Ext.Window({
	   			id:"addLinkWin",
	   			title:title,
			    width:Ext.lib.Dom.getViewWidth()-10,
		        height:Ext.lib.Dom.getViewHeight()-20,
		        html:'<iframe marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" height="100%" width="100%" src="'+url+'">'
			})
			win.show();
	   	}
	   	
	   	function returnLinkId(linkId){
	   		alert("保存成功!");
   			if(win){
   				win.close();
   			}
   			if(linkId != ""){
		   		window.frames['editTopoFrame'].window.transferLinkId(linkId);
   			}
	   	}
	   	
	</script>

<body style="margin:0px;padding:0px;">
	<iframe id="topoIframe" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" height="100%" width="100%">
</body>
</html>
