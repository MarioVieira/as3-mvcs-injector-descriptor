package org.as3.mvcsc.utils
{
	import flash.utils.getQualifiedClassName;
	
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.descriptors.DescriptorCairngormModelLocator;
	import org.as3.mvcsc.descriptors.DescriptorMediator;
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;
	import org.as3.mvcsc.model.BackgroundProcesses;
	import org.as3.mvcsc.model.CairngormBridge;
	import org.as3.mvcsc.model.Commands;
	import org.as3.mvcsc.model.Controls;
	import org.as3.mvcsc.model.Models;
	import org.as3.mvcsc.model.Services;
	import org.as3.mvcsc.model.Views;
	
	public class UtilsGetDefaultDescriptor
	{
		public static function getDefaultModelRules():Models
		{
			var modelMapping:Models = new Models();
			
			/*addModel(ModelUserInfo, modelMapping);
			addModel(ModelRemoteServiceStatus, modelMapping);
			addModel(ModelDownloads, modelMapping);
			addModel(ModelGenrePage, modelMapping);*/
			
			return modelMapping;
		}
		
		public static function getDefaultViewRules():Views
		{
			var viewRules:Views = new Views();
			
			/*addView(ComponentDownloader, MediatorDownloader, viewRules);	
			addView(ComponentGenreScreen, MediatorGenreScreen, viewRules);*/
			
			return viewRules;
		}
		
		public static function getDefaultControlRules():Controls
		{
			var controlRules:Controls = new Controls();
			
			/*addControl(ControlCommonUI, controlRules);
			addControl(ControlGenreScreen, controlRules);*/
			
			return controlRules;
		}
		
		
		public static function getDefaultServiceRules():Services
		{
			var serviceRules:Services = new Services();
			
			/*addService(ServiceLogger, null, serviceRules);
			addService(IServiceLayout, ServiceLayout, serviceRules);
			addService(IServiceDownload, ServiceDownload, serviceRules);
			addService(IServiceGenreInfo, ServiceGenreInfo, serviceRules);
			addService(IServicePagesInfo, ServicePageInfo, serviceRules);*/
			
			return serviceRules;
		}
		
		public static function getDefaultSignalCommandRules():Commands
		{
			var signalCommandRules:Commands = new Commands();
			
			/*addSignalCommandMap(RemoteServiceStatus, RemoteServiceStatusCommand, signalCommandRules);*/
			
			return signalCommandRules;
		}
		
		public static function getDefaultBackgroundProcesses():BackgroundProcesses
		{
			var backgroundProcessMapping:BackgroundProcesses = new BackgroundProcesses();
			
			return backgroundProcessMapping;
		}
		
		public static function getDefaultCairngormEventRules():CairngormBridge
		{
			var cairngormEventRules:CairngormBridge = new CairngormBridge();
			
			/*addCairngormModelLocator(1, EnumsCairngorm.PLAYER_MODEL_NICK, PlayerModelLocator, cairngormEventRules);
			addCairngormEventToBridge(GetPurchasedTracksEvent.GET_PURCHASED_TRACKS, GetPurchasedTracksEvent, VOGetPurchasedTracks, cairngormEventRules, SignalGetPurchasedTracks);
			*/
			return cairngormEventRules;
		}

		private static function addCairngormModelLocator(uid:Number, nick:String, modelLocator:*, cairngormEventRules:CairngormBridge):void
		{
			var modelInfo:DescriptorCairngormModelLocator = new DescriptorCairngormModelLocator();
			
			modelInfo.uid 				= uid;
			modelInfo.nick 				= nick;
			modelInfo.modelLocatorQName = getQualifiedClassName(modelLocator);
			
			cairngormEventRules.cairngornModelLocators.push(modelInfo);
		}
		
		public static function addModel(whenAskedFor:Class, modelMapping:Models):void
		{
			modelMapping.descriptorCollection.push( UtilsMapping.getInjectorRule(whenAskedFor) );
		}
		
		public static function addView(mapView:Class, mediatorClass:Class, mediatorMapping:Views):void
		{
			var mediatorRule:DescriptorMediator = new DescriptorMediator();
			
			mediatorRule.mapViewQName 			= getQualifiedClassName(mapView);
			mediatorRule.mediatorQName 			= getQualifiedClassName(mediatorClass);
			
			mediatorMapping.descriptorCollection.push(mediatorRule);
		}
		
		public static function addControl(whenAskedFor:Class, controlMapping:Controls):void
		{
			controlMapping.descriptorCollection.push( UtilsMapping.getInjectorRule(whenAskedFor) );			
		}
		
		public static function addService(whenAskedFor:Class, useClass:Class, servicesMapping:Services):void
		{
			servicesMapping.descriptorCollection.push( UtilsMapping.getInjectorRule(whenAskedFor, useClass) );
		}
		
		public static function addSignalCommandMap(signalClass:Class, signalCommand:Class, signalCommandMapping:Commands):void
		{
			var commandRule:DescriptorSignalCommand = new DescriptorSignalCommand();
			commandRule.signalClassQName 	= getQualifiedClassName(signalClass);
			commandRule.signalCommandQName 	= getQualifiedClassName(signalCommand);
			
			signalCommandMapping.descriptorCollection.push(commandRule); 
		}
		
		public static function addCairngormEventToBridge(cairngormEventType:String, cairngormEventQName:Class, valueObjectQNameToReceiveEventProperties:Class, model:CairngormBridge,signalClass:Class):void
		{
			var eventRule:DescriptorCairngormEventMap = new DescriptorCairngormEventMap();
			
			eventRule.cairngormEventType  					   = cairngormEventType; 
			eventRule.signalClassQName						   = getQualifiedClassName(signalClass);
			eventRule.cairngormEventQName 					   = getQualifiedClassName(cairngormEventQName);
			eventRule.valueObjectQNameToReceiveEventProperties = getQualifiedClassName(valueObjectQNameToReceiveEventProperties);
			
			model.descriptorCollection.push(eventRule);
		}
		
		public static function addBackgroundProcess(backgroundServiceInterfaceQName:String, backgroundProcesses:BackgroundProcesses):void
		{
			var backgroundProcessRule:DescriptorBackgroundProcess = new DescriptorBackgroundProcess();
			backgroundProcessRule.backgroundServiceInterfaceQName = getQualifiedClassName(backgroundServiceInterfaceQName);
			
			backgroundProcesses.descriptorCollection.push(backgroundProcessRule);
		}
		
	}
}