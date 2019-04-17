1. 把analysis.war 放入<PPM_SERVER>/conf/deploy目录
2. 修改analysis 中数据库的配置
3.  编辑 <PPM_SERVER>/conf/server.xml
	添加
		<Context antiJARLocking="true" path="/analysis" docBase="analysis.war">
			<Listener className="com.mercury.itg.core.debug.monitor.PPMTomcatMonitor"/>
		</Context>
