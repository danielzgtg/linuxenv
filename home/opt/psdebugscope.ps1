# Debugger for PowerShell variable scopes
# MIT-licensed from https://github.com/SeeminglyScience/seeminglyscience.github.com/blob/c77c1565426de4b2dd9cd7fb4c50215f85b5d240/_posts/2017-09-30-invocation-operators-states-and-scopes.md
$global:debugTypeDefinition = @'
using System;
using System.Management.Automation;
using System.Reflection;

namespace PSStateTree.Commands
{
    [OutputType(typeof(StateTreeInfo))]
    [Cmdlet(VerbsCommon.Show, "PSStateTree")]
    public class ShowPSStateTreeCommand : PSCmdlet
    {
        private struct StateTreeInfo
        {
            public int ExecutionContext;
            public int TopLevelSessionState;
            public int EngineSessionState;
            public int GlobalScope;
            public int ModuleScope;
            public int ScriptScope;
            public int ParentScope;
            public int ParentParentScope;
            public int CurrentScope;
        }

        private const BindingFlags BINDING_FLAGS = BindingFlags.Instance | BindingFlags.NonPublic;

        protected override void ProcessRecord()
        {
            StateTreeInfo result;
            EngineIntrinsics engine = GetVariableValue("ExecutionContext") as EngineIntrinsics;
            var context = engine
                .GetType()
                .GetTypeInfo()
                .GetField("_context", BINDING_FLAGS)
                .GetValue(engine);

            var stateInternal = GetProperty("Internal", SessionState);
            var currentScope = GetProperty("CurrentScope", stateInternal);
            var parent = GetProperty("Parent", currentScope);

            result.ParentScope = 0;
            result.ParentParentScope = 0;
            if (parent != null)
            {
                result.ParentScope = parent.GetHashCode();
                var parentParent = GetProperty("Parent", parent);
                if (parentParent != null)
                {
                    result.ParentParentScope = parentParent.GetHashCode();
                }
            }


            result.ExecutionContext = context.GetHashCode();
            result.EngineSessionState = GetProperty("EngineSessionState", context).GetHashCode();
            result.TopLevelSessionState = GetProperty("TopLevelSessionState", context).GetHashCode();
            result.CurrentScope = currentScope.GetHashCode();
            result.ScriptScope = GetProperty("ScriptScope", stateInternal).GetHashCode();
            result.ModuleScope = GetProperty("ModuleScope", stateInternal).GetHashCode();
            result.GlobalScope = GetProperty("GlobalScope", stateInternal).GetHashCode();

            WriteObject(result);
        }

        private object GetProperty(string propertyName, object source)
        {
            if (string.IsNullOrEmpty(propertyName))
            {
                throw new ArgumentNullException("propertyName");
            }

            if (source == null)
            {
                throw new ArgumentNullException("source");
            }

            return source
                .GetType()
                .GetTypeInfo()
                .GetProperty(propertyName, BINDING_FLAGS)
                .GetValue(source);
        }
    }
}
'@

if (-not ('PSStateTree.Commands.ShowPSStateTreeCommand' -as [type])) {
    $module = New-Module -Name PSStateTree -ScriptBlock {
        $types = Add-Type -TypeDefinition $global:debugTypeDefinition -PassThru
        Import-Module -Assembly $types[0].Assembly
        Export-ModuleMember -Cmdlet Show-PSStateTree
    }
    Import-Module $module
}
