package org.as3.mvcsc.utils
{
	import flash.utils.getQualifiedClassName;
	
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.descriptors.DescriptorCairngormModelLocator;
	import org.as3.mvcsc.descriptors.DescriptorMediator;
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.as3.mvcsc.vo.Commands;
	import org.as3.mvcsc.vo.Controls;
	import org.as3.mvcsc.vo.Models;
	import org.as3.mvcsc.vo.Services;
	import org.as3.mvcsc.vo.Views;
	
	/**
	 * 
	 * 
	 * Provides a default XML MVCS Commands descriptor to be placed at app:/descriptors/
	 * 
	 * @author Mario Vieira
	 */
	public class UtilsGetDefaultDescriptor
	{
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getDefaultModelRules():Models
		{
			var modelMapping:Models = new Models();
			
			/*addModel(ModelUserInfo, modelMapping);
			addModel(ModelRemoteServiceStatus, modelMapping);
			addModel(ModelDownloads, modelMapping);
			addModel(ModelGenrePage, modelMapping);*/
			
			return modelMapping;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getDefaultViewRules():Views
		{
			var viewRules:Views = new Views();
			
			/*addView(ComponentDownloader, MediatorDownloader, viewRules);	
			addView(ComponentGenreScreen, MediatorGenreScreen, viewRules);*/
			
			return viewRules;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getDefaultControlRules():Controls
		{
			var controlRules:Controls = new Controls();
			
			/*addControl(ControlCommonUI, controlRules);
			addControl(ControlGenreScreen, controlRules);*/
			
			return controlRules;
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
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
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getDefaultSignalCommandRules():Commands
		{
			var signalCommandRules:Commands = new Commands();
			
			/*addSignalCommandMap(RemoteServiceStatus, RemoteServiceStatusCommand, signalCommandRules);*/
			
			return signalCommandRules;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getDefaultBackgroundProcesses():BackgroundProcesses
		{
			var backgroundProcessMapping:BackgroundProcesses = new BackgroundProcesses();
			
			return backgroundProcessMapping;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getDefaultCairngormEventRules():CairngormBridge
		{
			var cairngormEventRules:CairngormBridge = new CairngormBridge();
			
			/*addCairngormModelLocator(1, EnumsCairngorm.PLAYER_MODEL_NICK, PlayerModelLocator, cairngormEventRules);
			addCairngormEventToBridge(GetPurchasedTracksEvent.GET_PURCHASED_TRACKS, GetPurchasedTracksEvent, VOGetPurchasedTracks, cairngormEventRules, SignalGetPurchasedTracks);
			*/
			return cairngormEventRules;
		}

		/**
		 * 
		 * @param uid
		 * @param nick
		 * @param modelLocator
		 * @param cairngormEventRules
		 * 
		 */
		private static function addCairngormModelLocator(uid:Number, nick:String, modelLocator:*, cairngormEventRules:CairngormBridge):void
		{
			var modelInfo:DescriptorCairngormModelLocator = new DescriptorCairngormModelLocator();
			
			modelInfo.uid 				= uid;
			modelInfo.nick 				= nick;
			modelInfo.modelLocatorQName = getQualifiedClassName(modelLocator);
			
			cairngormEventRules.cairngornModelLocators.push(modelInfo);
		}
		
		/**
		 * 
		 * @param whenAskedFor
		 * @param modelMapping
		 * 
		 */
		public static function addModel(whenAskedFor:Class, modelMapping:Models):void
		{
			modelMapping.descriptorCollection.push( UtilsMapping.getInjectorRule(whenAskedFor) );
		}
		
		/**
		 * 
		 * @param mapView
		 * @param mediatorClass
		 * @param mediatorMapping
		 * 
		 */
		public static function addView(mapView:Class, mediatorClass:Class, mediatorMapping:Views):void
		{
			var mediatorRule:DescriptorMediator = new DescriptorMediator();
			
			mediatorRule.mapViewQName 			= getQualifiedClassName(mapView);
			mediatorRule.mediatorQName 			= getQualifiedClassName(mediatorClass);
			
			mediatorMapping.descriptorCollection.push(mediatorRule);
		}
		
		/**
		 * 
		 * @param whenAskedFor
		 * @param controlMapping
		 * 
		 */
		public static function addControl(whenAskedFor:Class, controlMapping:Controls):void
		{
			controlMapping.descriptorCollection.push( UtilsMapping.getInjectorRule(whenAskedFor) );			
		}
		
		/**
		 * 
		 * @param whenAskedFor
		 * @param useClass
		 * @param servicesMapping
		 * 
		 */
		public static function addService(whenAskedFor:Class, useClass:Class, servicesMapping:Services):void
		{
			servicesMapping.descriptorCollection.push( UtilsMapping.getInjectorRule(whenAskedFor, useClass) );
		}
		
		/**
		 * 
		 * @param signalClass
		 * @param signalCommand
		 * @param signalCommandMapping
		 * 
		 */
		public static function addSignalCommandMap(signalClass:Class, signalCommand:Class, signalCommandMapping:Commands):void
		{
			var commandRule:DescriptorSignalCommand = new DescriptorSignalCommand();
			commandRule.signalClassQName 	= getQualifiedClassName(signalClass);
			commandRule.signalCommandQName 	= getQualifiedClassName(signalCommand);
			
			signalCommandMapping.descriptorCollection.push(commandRule); 
		}
		
		/**
		 * 
		 * @param cairngormEventType
		 * @param cairngormEventQName
		 * @param valueObjectQNameToReceiveEventProperties
		 * @param model
		 * @param signalClass
		 * 
		 */
		public static function addCairngormEventToBridge(cairngormEventType:String, cairngormEventQName:Class, valueObjectQNameToReceiveEventProperties:Class, model:CairngormBridge,signalClass:Class):void
		{
			var eventRule:DescriptorCairngormEventMap = new DescriptorCairngormEventMap();
			
			eventRule.cairngormEventType  					   = cairngormEventType; 
			eventRule.signalClassQName						   = getQualifiedClassName(signalClass);
			eventRule.cairngormEventQName 					   = getQualifiedClassName(cairngormEventQName);
			eventRule.valueObjectQNameToReceiveEventProperties = getQualifiedClassName(valueObjectQNameToReceiveEventProperties);
			
			model.descriptorCollection.push(eventRule);
		}
		
		/**
		 * 
		 * TO DO:
		 * @param backgroundServiceInterfaceQName
		 * @param backgroundProcesses
		 * 
		 */
		public static function addBackgroundProcess(backgroundServiceInterfaceQName:String, backgroundProcesses:BackgroundProcesses):void
		{
			/*var backgroundProcessRule:DescriptorBackgroundProcess = new DescriptorBackgroundProcess();
			backgroundProcessRule.processQNameIBackgroundProcess  = getQualifiedClassName(backgroundServiceInterfaceQName);
			
			backgroundProcesses.descriptorCollection.push(backgroundProcessRule);*/
		}
		
	}
}