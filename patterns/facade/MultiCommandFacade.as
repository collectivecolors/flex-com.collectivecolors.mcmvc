package com.collectivecolors.mcmvc.patterns.facade
{
	//----------------------------------------------------------------------------
	// Imports
	
	import com.collectivecolors.mcmvc.core.MultiCommandController;
	import com.collectivecolors.mcmvc.interfaces.IMultiCommandFacade;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	//----------------------------------------------------------------------------	
	
	public class MultiCommandFacade extends Facade implements IMultiCommandFacade
	{
		//--------------------------------------------------------------------------
    // Constructor
    
		/**
		 * MultiCommandFacade Singleton Factory method
		 * 
		 * @return the Singleton instance of the ExtensibleFacade
		 */
		public static function getInstance( ) : IMultiCommandFacade
		{
			if ( instance == null ) instance = new MultiCommandFacade( );
			return instance as IMultiCommandFacade;
		}
		
		//--------------------------------------------------------------------------
		// Initialization
		
		/**
		 * Initialize the <code>Controller</code>.
		 * 
		 * <P>
		 * Called by the <code>initializeFacade</code> method.
		 * Override this method in your subclass of <code>Facade</code> 
		 * if one or both of the following are true:
		 * <UL>
		 * <LI> You wish to initialize a different <code>IController</code>.</LI>
		 * <LI> You have <code>Commands</code> to register with the <code>Controller</code> at startup.</code>. </LI>		  
		 * </UL>
		 * If you don't want to initialize a different <code>IController</code>, 
		 * call <code>super.initializeController()</code> at the beginning of your
		 * method, then register <code>Command</code>s.
		 * </P>
		 */
		override protected function initializeController( ):void {
			if ( controller != null ) return;
			controller = MultiCommandController.getInstance( );
		}
		
		//--------------------------------------------------------------------------
		// Controller methods

		/**
		 * Check if a specific Command is registered for a given Notification 
		 * 
		 * @param noteName the name of the <code>INotification</code> to search the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to search for
		 * @return whether the Command is currently registered for the given <code>notificationName</code>.
		 */
    public function hasCommandClass( noteName : String, commandClassRef : Class ) : Boolean
    {
      return MultiCommandController( controller ).hasCommandClass( noteName, 
                                                                   commandClassRef );
    }
    
    /**
		 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
		 * 
		 * @param noteName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to remove
		 */
    public function removeCommandClass( noteName : String, commandClassRef : Class ) : void
    {
      MultiCommandController( controller ).removeCommandClass( noteName,
                                                               commandClassRef );
    }		
	}
}