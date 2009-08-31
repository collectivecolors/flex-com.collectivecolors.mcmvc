package com.collectivecolors.mcmvc.core
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.mcmvc.interfaces.IMultiCommandController;
  
  import flash.utils.getQualifiedClassName;
  
  import org.puremvc.as3.core.Controller;
  import org.puremvc.as3.interfaces.ICommand;
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.observer.Observer;

  //----------------------------------------------------------------------------

  public class MultiCommandController extends Controller implements IMultiCommandController
  {
    //--------------------------------------------------------------------------
    // Constructor
    
		/**
		 * <code>Controller</code> Singleton Factory method.
		 * 
		 * @return the Singleton instance of <code>Controller</code>
		 */
		public static function getInstance( ) : IMultiCommandController
		{
			if ( instance == null ) instance = new MultiCommandController( );
			return instance as IMultiCommandController;
		}

		//--------------------------------------------------------------------------
		// Command methods
	
		/**
		 * Register a particular <code>ICommand</code> class as the handler 
		 * for a particular <code>INotification</code>.
		 * 
		 * <P>
		 * If an <code>ICommand</code> has already been registered to 
		 * handle <code>INotification</code>s with this name, it is no longer
		 * used, the new <code>ICommand</code> is used instead.</P>
		 * 
		 * The Observer for the new ICommand is only created if this the 
		 * first time an ICommand has been regisered for this Notification name.
		 * 
		 * @param notificationName the name of the <code>INotification</code>
		 * @param commandClassRef the <code>Class</code> of the <code>ICommand</code>
		 */
		override public function registerCommand( noteName : String, commandClassRef : Class ) : void
		{
			if ( commandMap[ noteName ] == null ) {
			  view.registerObserver( noteName, new Observer( executeCommand, this ) );
			  commandMap[ noteName ] = new Object( );
			}
			
			commandMap[ noteName ][ getQualifiedClassName( commandClassRef ) ] = commandClassRef;		
		}
		
    /**
		 * Check if a specific Command is registered for a given Notification 
		 * 
		 * @param noteName the name of the <code>INotification</code> to search the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to search for
		 * @return whether the Command is currently registered for the given <code>notificationName</code>.
		 */
    public function hasCommandClass( noteName : String, commandClassRef : Class ) : Boolean
    {
      if ( hasCommand( noteName )
           && commandMap[ noteName ].hasOwnProperty( getQualifiedClassName( commandClassRef ) ) )
      {
        return true;
      }
      
      return false;  
    }
    
		/**
		 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
		 * 
		 * @param noteName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to remove
		 */
    public function removeCommandClass( noteName : String, commandClassRef : Class ) : void
    {
      var commandClassName : String = getQualifiedClassName( commandClassRef );
      
      if ( hasCommand( noteName )
           && commandMap[ noteName ].hasOwnProperty( commandClassName ) )
      {
        var hasCommandClasses : Boolean = false;
        
        // Remove this command class from map
        delete commandMap[ noteName ][ commandClassName ];
        
        // Look for any remaining command classes for this notification.
        for ( var commandName : String in commandMap[ noteName ] )
        {
          hasCommandClasses = true;
          break;
        }
        
        // Remove notification from command map if no more command classes 
        // registered.
        if ( ! hasCommandClasses )
        {
          removeCommand( noteName );
        }
      }  
    }
    
		/**
		 * If an <code>ICommand</code> has previously been registered 
		 * to handle a the given <code>INotification</code>, then it is executed.
		 * 
		 * @param note an <code>INotification</code>
		 */
		override public function executeCommand( note : INotification ) : void
		{
			var commandClasses : Object = commandMap[ note.getName( ) ];
			if ( commandClasses == null ) return;
			
			// Remember, commands are not meant to be executed in any particular 
			// order.  They should be completely independent of each other.
			var commandInstance : ICommand;
			
			for ( var commandClassName : String in commandClasses )
			{
			  commandInstance = new commandClasses[ commandClassName ];
			  commandInstance.execute( note );
			}
		}
  }
}