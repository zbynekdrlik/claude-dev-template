#!/usr/bin/env python3
"""
Claude API Client (Python)
A Python wrapper for the Anthropic Claude API with error handling and retry logic
"""

import json
import time
import os
from pathlib import Path
from typing import Dict, List, Optional, Any
import asyncio
from anthropic import Anthropic
from anthropic.types import Message


class ClaudeClient:
    """Python client for interacting with Claude API"""
    
    def __init__(self, api_key: Optional[str] = None, config_path: Optional[str] = None):
        """
        Initialize Claude client
        
        Args:
            api_key: Anthropic API key (defaults to ANTHROPIC_API_KEY env var)
            config_path: Path to configuration file
        """
        self.api_key = api_key or os.getenv('ANTHROPIC_API_KEY')
        self.config = self._load_config(config_path)
        
        if not self.api_key:
            raise ValueError('Anthropic API key is required')
            
        self.client = Anthropic(api_key=self.api_key)
    
    def _load_config(self, config_path: Optional[str] = None) -> Dict[str, Any]:
        """Load configuration from file"""
        default_config = {
            'model': 'claude-sonnet-4-20250514',
            'max_tokens': 4000,
            'temperature': 0.7,
            'timeout': 30,
            'retry_attempts': 3,
            'retry_delay': 1.0
        }
        
        if config_path is None:
            config_path = Path(__file__).parent.parent / 'config' / 'claude-config.json'
        
        try:
            with open(config_path, 'r') as f:
                file_config = json.load(f)
                return {**default_config, **file_config}
        except FileNotFoundError:
            print(f'Warning: Config file not found at {config_path}, using defaults')
            return default_config
    
    async def complete(self, 
                      prompt: str,
                      system: Optional[str] = None,
                      context: Optional[str] = None,
                      model: Optional[str] = None,
                      max_tokens: Optional[int] = None,
                      temperature: Optional[float] = None) -> Dict[str, Any]:
        """
        Send a completion request to Claude
        
        Args:
            prompt: The main prompt text
            system: System prompt (optional)
            context: Additional context to prepend to prompt
            model: Model to use (defaults to config)
            max_tokens: Maximum tokens in response
            temperature: Response randomness (0.0-1.0)
            
        Returns:
            Dict with response content and metadata
        """
        if not prompt:
            raise ValueError('Prompt is required')
        
        # Build message content
        content = f"{context}\n\n{prompt}" if context else prompt
        
        # Request parameters
        request_params = {
            'model': model or self.config['model'],
            'max_tokens': max_tokens or self.config['max_tokens'],
            'temperature': temperature or self.config['temperature'],
            'messages': [{
                'role': 'user',
                'content': content
            }]
        }
        
        if system or self.config.get('system_prompt'):
            request_params['system'] = system or self.config['system_prompt']
        
        return await self._send_request(request_params)
    
    async def _send_request(self, request_params: Dict[str, Any], attempt: int = 1) -> Dict[str, Any]:
        """Send request with retry logic"""
        try:
            response = await asyncio.to_thread(self.client.messages.create, **request_params)
            
            return {
                'content': response.content[0].text,
                'usage': {
                    'input_tokens': response.usage.input_tokens,
                    'output_tokens': response.usage.output_tokens
                },
                'model': response.model,
                'stop_reason': response.stop_reason
            }
        except Exception as error:
            if attempt < self.config['retry_attempts'] and self._should_retry(error):
                print(f'Request failed (attempt {attempt}), retrying...')
                await asyncio.sleep(self.config['retry_delay'] * attempt)
                return await self._send_request(request_params, attempt + 1)
            
            raise self._handle_error(error)
    
    def _should_retry(self, error: Exception) -> bool:
        """Determine if error should trigger a retry"""
        retryable_statuses = [429, 500, 502, 503, 504]
        return hasattr(error, 'status_code') and error.status_code in retryable_statuses
    
    def _handle_error(self, error: Exception) -> Exception:
        """Handle and format errors"""
        if hasattr(error, 'status_code'):
            if error.status_code == 401:
                return ValueError('Invalid API key')
            elif error.status_code == 429:
                return ValueError('Rate limit exceeded')
            elif error.status_code == 400:
                return ValueError(f'Bad request: {str(error)}')
        
        return ValueError(f'API error: {str(error)}')
    
    def load_prompt(self, template_name: str) -> str:
        """Load prompt template from file"""
        prompt_path = Path(__file__).parent.parent / 'config' / 'prompts' / f'{template_name}.md'
        
        try:
            with open(prompt_path, 'r') as f:
                return f.read()
        except FileNotFoundError:
            raise FileNotFoundError(f'Could not load prompt template: {template_name}')
    
    async def review_code(self, code: str, **kwargs) -> Dict[str, Any]:
        """Code review helper"""
        template = self.load_prompt('code-review')
        prompt = template.replace('[INSERT CODE HERE]', code)
        
        return await self.complete(
            prompt=prompt,
            system='You are a senior software engineer conducting a thorough code review.',
            **kwargs
        )
    
    async def generate_docs(self, code: str, **kwargs) -> Dict[str, Any]:
        """Documentation generation helper"""
        template = self.load_prompt('documentation')
        prompt = template.replace('[INSERT CODE HERE]', code)
        
        return await self.complete(
            prompt=prompt,
            system='You are a technical documentation specialist.',
            **kwargs
        )
    
    async def debug_code(self, 
                        code: str, 
                        problem_description: str, 
                        error_messages: str = '', 
                        **kwargs) -> Dict[str, Any]:
        """Debugging helper"""
        template = self.load_prompt('debugging')
        prompt = (template
                 .replace('[DESCRIBE THE ISSUE]', problem_description)
                 .replace('[INSERT PROBLEMATIC CODE]', code)
                 .replace('[INSERT ERROR MESSAGES]', error_messages))
        
        return await self.complete(
            prompt=prompt,
            system='You are an expert debugger helping to identify and fix code issues.',
            **kwargs
        )


# Example usage
if __name__ == '__main__':
    import asyncio
    from dotenv import load_dotenv
    
    load_dotenv()
    
    async def main():
        client = ClaudeClient()
        
        # Simple example
        response = await client.complete(
            prompt='Create a Python function that validates email addresses using regex',
            temperature=0.3
        )
        
        print('Generated Code:')
        print(response['content'])
        print(f"\nTokens used: {response['usage']['output_tokens']}")
    
    asyncio.run(main())